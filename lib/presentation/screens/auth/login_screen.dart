import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:answer_sheet_auditor/presentation/screens/auth/sign_up.dart';
import 'package:answer_sheet_auditor/presentation/screens/home/home_screen.dart';
import 'package:answer_sheet_auditor/presentation/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AuthProvider authProvider = context.watch<AuthProvider>();

    String _email, _password = '';

    return Scaffold(
      body: SafeArea(
        child: authProvider.status == AuthStatus.LOADING
            ? const Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //header space
                        SizedBox(
                          height: screenSize.height * 0.1,
                        ),
                        //heading text
                        SizedBox(
                          width: screenSize.width * 0.4,
                          child: FittedBox(
                            child: Text(
                              'Welcome,',
                              style: textTheme.headline1,
                            ),
                          ),
                        ),
                        //subtitle text
                        SizedBox(
                          width: screenSize.width * 0.6,
                          child: FittedBox(
                            child: Text(
                              'Sign in to continue !',
                              style: textTheme.subtitle1,
                            ),
                          ),
                        ),
                        //spacing
                        SizedBox(
                          height: screenSize.height * 0.15,
                        ),
                        //input form
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //email input
                              TextInput(
                                label: 'Email',
                                inputType: TextInputType.emailAddress,
                                onSaved: (String value) =>
                                    _email = value.trim(),
                                validator: (String value) {
                                  if (value.trim().isEmpty) {
                                    return '''
This field can't be empty !''';
                                  }
                                  if (!RegExp(
                                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                      .hasMatch(value.trim())) {
                                    return 'Enter a valid email !';
                                  }
                                  return null;
                                },
                              ),
                              //spacing
                              SizedBox(height: screenSize.height * 0.04),
                              //password input
                              TextInput(
                                label: 'Password',
                                inputType: TextInputType.emailAddress,
                                obscureText: true,
                                onSaved: (String value) =>
                                    _password = value.trim(),
                                validator: (String value) =>
                                    value.trim().isEmpty
                                        ? '''
This field can't be empty!'''
                                        : null,
                              ),
                            ],
                          ),
                        ),
                        //spacing
                        SizedBox(height: screenSize.height * 0.04),
                        //forget password button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Auth.instance.sendPasswordResetEmail(_email);
                            },
                            child: SizedBox(
                              width: screenSize.width * 0.3,
                              child: FittedBox(
                                child: Text(
                                  'Forget Password ?',
                                  style: textTheme.bodyText1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //spacing
                        SizedBox(height: screenSize.height * 0.06),
                        //login button
                        SizedBox(
                          width: screenSize.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              final form = _formKey.currentState;

                              if (form.validate()) {
                                //saving the form
                                form.save();
                                await authProvider.loginUserWithEmail(
                                  _email,
                                  _password,
                                );
                                if (authProvider.status ==
                                    AuthStatus.AUTHENTICATED) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => HomeScreen()));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: authProvider.error ??
                                          'Error Occurred',
                                      toastLength: Toast.LENGTH_LONG);
                                }
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      //bottom actions
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //text part 1
            Text(
              '''
I'm a new user, ''',
              style: textTheme.subtitle2,
            ),
            //text part 2
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => SignupScreen()));
              },
              child: Text(
                'Sign Up',
                style: textTheme.button.copyWith(
                  color: AppTheme.ACCENT_COLOR,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
