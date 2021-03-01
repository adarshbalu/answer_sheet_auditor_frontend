import 'package:answer_sheet_auditor/core/presentation/widgets/buttons/blue_button.dart';
import 'package:answer_sheet_auditor/core/presentation/widgets/buttons/yellow_button.dart';
import 'package:answer_sheet_auditor/core/presentation/widgets/text_input.dart';
import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddNewSheet extends StatefulWidget {
  @override
  _AddNewSheetState createState() => _AddNewSheetState();
}

class _AddNewSheetState extends State<AddNewSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        context.read<StorageProvider>().resetUploadStatus();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                //heading text
                SizedBox(
                  width: screenSize.width * 0.4,
                  child: FittedBox(
                    child: Text(
                      'New upload',
                      style: textTheme.headline1,
                    ),
                  ),
                ),
                //subtitle text
                SizedBox(
                  width: screenSize.width * 0.6,
                  child: FittedBox(
                    child: Text(
                      'Provide required details to continue !',
                      style: textTheme.subtitle1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<StorageProvider>(
                  builder: (_, provider, child) {
                    if (provider.imageFileStatus == FileStatus.SUCCESS) {
                      return AddNewSheetCard(
                        name: name,
                      );
                    } else if (provider.imageFileStatus == FileStatus.ERROR) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Fluttertoast.showToast(msg: 'Please pick image file');
                      });
                      return child;
                    }
                    return child;
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SvgPicture.asset(
                        Assets.ADD_DOCUMENT,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: TextInput(
                    label: 'Register number of sheet',
                    inputType: TextInputType.text,
                    onSaved: (String value) => name = value.trim(),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return '''
This field can't be empty !''';
                      }
                      if (value.trim().isEmpty) {
                        return 'Enter register number of sheet!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenSize.height * 0.04),
                Consumer<StorageProvider>(
                  builder: (_, provider, child) {
                    if (provider.imageFileStatus == FileStatus.SUCCESS) {
                      return BlueButton(
                          label: 'Upload sheet',
                          onPressed: () async {
                            final form = _formKey.currentState;

                            if (form.validate()) {
                              //saving the form
                              form.save();
                              final String uid = context.read<User>().uid;
                              await context
                                  .read<StorageProvider>()
                                  .uploadImageFile(name, uid);
                            }
                          });
                    }
                    return child;
                  },
                  child: YellowButton(
                    label: 'Select sheet',
                    onPressed: () async {
                      final form = _formKey.currentState;

                      if (form.validate()) {
                        form.save();

                        await context.read<StorageProvider>().pickImage();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<StorageProvider>(
                  builder: (_, provider, child) {
                    if (provider.uploadStatus == UploadStatus.UPLOADING) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (provider.uploadStatus == UploadStatus.UPLOADED) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Fluttertoast.showToast(msg: 'File uploaded');
                        Navigator.pop(context);
                      });
                      return child;
                    } else if (provider.uploadStatus == UploadStatus.ERROR) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Fluttertoast.showToast(msg: 'File upload failed');
                      });
                      return child;
                    } else {
                      return child;
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddNewSheetCard extends StatelessWidget {
  const AddNewSheetCard({Key key, this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.read<StorageProvider>().pickImage();
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 16,
            ),
            SvgPicture.asset(
              Assets.DOCUMENT_ADDED,
              height: 200,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
