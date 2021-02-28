import 'package:answer_sheet_auditor/core/presentation/widgets/text_input.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenSize.height * 0.1,
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
            //spacing
            SizedBox(
              height: screenSize.height * 0.15,
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

            SizedBox(
              width: screenSize.width,
              child: ElevatedButton(
                onPressed: () async {
                  final form = _formKey.currentState;

                  if (form.validate()) {
                    //saving the form
                    form.save();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Upload answer sheet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
