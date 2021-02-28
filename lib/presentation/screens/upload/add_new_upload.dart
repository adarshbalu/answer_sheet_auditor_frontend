import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:answer_sheet_auditor/presentation/widgets/blue_button.dart';
import 'package:answer_sheet_auditor/presentation/widgets/text_input.dart';
import 'package:answer_sheet_auditor/presentation/widgets/yellow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddNewUpload extends StatefulWidget {
  @override
  _AddNewUploadState createState() => _AddNewUploadState();
}

class _AddNewUploadState extends State<AddNewUpload> {
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
                Consumer<StorageProvider>(
                  builder: (_, provider, child) {
                    if (provider.textFileStatus == FileStatus.SUCCESS) {
                      return AddedTextFileCard(
                        name: provider.pickedFileName,
                      );
                    } else if (provider.textFileStatus == FileStatus.ERROR) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Fluttertoast.showToast(msg: 'Please pick Text file');
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
                SizedBox(
                  width: screenSize.width / 1.5,
                  child: FittedBox(
                    child: Text(
                      'Upload Answer key',
                      style: textTheme.headline1,
                    ),
                  ),
                ),
                //subtitle text
                SizedBox(
                  width: screenSize.width * 0.85,
                  child: FittedBox(
                    child: Text(
                      'Name of subject and answer key to continue !',
                      style: textTheme.subtitle1,
                    ),
                  ),
                ),
                //spacing
                SizedBox(
                  height: screenSize.height * 0.07,
                ),
                Form(
                  key: _formKey,
                  child: TextInput(
                    label: 'Name',
                    inputType: TextInputType.emailAddress,
                    onSaved: (String value) => name = value.trim(),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return '''
This field can't be empty !''';
                      }
                      if (value.trim().length < 5) {
                        return 'Enter name with more than 5 characters !';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenSize.height * 0.04),
                Consumer<StorageProvider>(
                  builder: (_, provider, child) {
                    if (provider.textFileStatus == FileStatus.SUCCESS) {
                      return BlueButton(
                          label: 'Upload key',
                          onPressed: () {
                            final form = _formKey.currentState;

                            if (form.validate()) {
                              //saving the form
                              form.save();
                              context
                                  .read<StorageProvider>()
                                  .uploadImageFile('asd');
                              form.reset();
                            }
                          });
                    }
                    return child;
                  },
                  child: YellowButton(
                    label: 'Add key',
                    onPressed: () {
                      final form = _formKey.currentState;

                      if (form.validate()) {
                        form.save();

                        context.read<StorageProvider>().pickText();
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

class AddedTextFileCard extends StatelessWidget {
  const AddedTextFileCard({
    Key key,
    @required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
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
