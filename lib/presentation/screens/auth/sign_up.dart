import 'package:answer_sheet_auditor/core/presentation/theme/theme.dart';
import 'package:answer_sheet_auditor/core/utils/assets.dart';
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:answer_sheet_auditor/presentation/screens/auth/login_screen.dart';
import 'package:answer_sheet_auditor/presentation/screens/home/home_screen.dart';
import 'package:answer_sheet_auditor/core/presentation/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStepTwo = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStepThree = GlobalKey<FormState>();

  static const Duration _pageTransitionDuration = Duration(milliseconds: 300);
  static const Curve _pageAnimationCurve = Cubic(0.1, 0.2, 0.7, 1.0);

  AuthProvider authProvider;

  PageController _pageController;

  String _userName, _email, _password;

  Size screenSize;
  TextTheme textTheme;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _buildPersonalDetailsSection(),
              _buildEmailSection(),
              _buildPasswordSection(),
              _buildFinishSection(),
            ],
          ),
        ),
      ),
      //bottom actions
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          //  crossAxisAlignment:CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //text part 1
            Text(
              '''
I'm already a member, ''',
              style: textTheme.subtitle2,
            ),
            //text part 2
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: Text(
                'Log In',
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

  ///[return widget for Signup Step One]
  Widget _buildPersonalDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //back icon
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: SvgPicture.asset(
                Assets.BACK,
              ),
            ),
            //header space
            SizedBox(height: screenSize.height * 0.1),
            //heading text
            SizedBox(
              width: screenSize.width * 0.4,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Hi There! :)',
                  style: textTheme.headline1,
                ),
              ),
            ),
            //subtitle text
            SizedBox(
              width: screenSize.width * 0.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Text(
                  'Introduce Yourself',
                  style: textTheme.subtitle1,
                ),
              ),
            ),
            //spacing
            SizedBox(
              height: screenSize.height * 0.08,
            ),
            //input form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //email input
                  TextInput(
                    label: 'Name',
                    autofocus: true,
                    initialValue: _userName,
                    inputType: TextInputType.text,
                    onSaved: (String value) => _userName = value.trim(),
                    validator: (String value) => value.trim().isEmpty
                        ? '''
This field can't be empty!'''
                        : null,
                  ),
                  //spacing
                  SizedBox(height: screenSize.height * 0.04),
                ],
              ),
            ),
            //spacing
            SizedBox(height: screenSize.height * 0.06),
            //login button
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: screenSize.width * 0.3,
                child: ElevatedButton(
                  onPressed: () {
                    //unfocusing
                    FocusScope.of(context).unfocus();
                    //verification step 1
                    final form = _formKey.currentState;
                    //validating
                    if (form.validate()) {
                      //saving form
                      form.save();
                      //redirecting to next step
                      _pageController.animateToPage(
                        1,
                        duration: _pageTransitionDuration,
                        curve: _pageAnimationCurve,
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///[return widget for Signup Step Two]
  Widget _buildEmailSection() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //back icon
            InkWell(
              onTap: () => _pageController.animateToPage(
                0,
                duration: _pageTransitionDuration,
                curve: _pageAnimationCurve,
              ),
              child: SvgPicture.asset(
                Assets.BACK,
              ),
            ),
            //header space
            SizedBox(height: screenSize.height * 0.1),
            //heading text
            SizedBox(
              width: screenSize.width * 0.4,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Hi $_userName!',
                  style: textTheme.headline1,
                ),
              ),
            ),
            //subtitle text
            SizedBox(
              width: screenSize.width * 0.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Text(
                  '''
What's your email ? ''',
                  style: textTheme.subtitle1,
                ),
              ),
            ),
            //spacing
            SizedBox(
              height: screenSize.height * 0.08,
            ),
            //input form
            Form(
              key: _formKeyStepTwo,
              child: TextInput(
                label: 'Email ID',
                initialValue: _email,
                inputType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                onSaved: (String value) => _email = value.trim(),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return '''
This field can't be empty !''';
                  }
                  if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                      .hasMatch(value.trim())) {
                    return 'Enter a valid email !';
                  }
                  return null;
                },
              ),
            ),
            //spacing
            SizedBox(height: screenSize.height * 0.06),
            //login button
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: screenSize.width * 0.3,
                child: ElevatedButton(
                  onPressed: () {
                    //unfocusing
                    FocusScope.of(context).unfocus();

                    //verification step 1
                    final form = _formKeyStepTwo.currentState;

                    //validating
                    if (form.validate()) {
                      //saving form
                      form.save();

                      //redirecting to next step
                      _pageController.animateToPage(
                        2,
                        duration: _pageTransitionDuration,
                        curve: _pageAnimationCurve,
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///[return widget for Signup Step Three]
  Widget _buildPasswordSection() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //back icon
            InkWell(
              onTap: () => _pageController.animateToPage(
                1,
                duration: _pageTransitionDuration,
                curve: _pageAnimationCurve,
              ),
              child: SvgPicture.asset(
                Assets.BACK,
              ),
            ),
            //header space
            SizedBox(height: screenSize.height * 0.1),
            //heading text
            SizedBox(
              width: screenSize.width * 0.4,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomLeft,
                child: Text(
                  '''
Let's Think ''',
                  style: textTheme.headline1,
                ),
              ),
            ),
            //subtitle text
            SizedBox(
              width: screenSize.width * 0.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Text(
                  'Of a Password :) ',
                  style: textTheme.subtitle1,
                ),
              ),
            ),
            //spacing
            SizedBox(
              height: screenSize.height * 0.08,
            ),
            //input form
            Form(
              key: _formKeyStepThree,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //email input
                  TextInput(
                    label: 'Password',
                    initialValue: _password,
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    autofocus: true,
                    onSaved: (String value) => _password = value.trim(),
                    onChanged: (String newValue) => _password = newValue.trim(),
                    validator: (String value) => value.trim().length < 8
                        ? 'Password must be atleast 8 characters long !'
                        : null,
                  ),
                  //spacing
                  SizedBox(height: screenSize.height * 0.04),
                  //password input
                  TextInput(
                    label: 'Confirm Password',
                    initialValue: _password,
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return '''
This field can't be empty !''';
                      }
                      if (value.trim() != _password) {
                        return '''
Password and confirm password didn't match !''';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            //spacing
            SizedBox(height: screenSize.height * 0.06),
            //login button
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: screenSize.width * 0.3,
                child: ElevatedButton(
                    onPressed: () {
                      //unfocusing
                      FocusScope.of(context).unfocus();

                      //verification step 1
                      final form = _formKeyStepThree.currentState;

                      //validating
                      if (form.validate()) {
                        //saving form
                        form.save();

                        //redirecting to next step
                        _pageController.animateToPage(
                          3,
                          duration: _pageTransitionDuration,
                          curve: _pageAnimationCurve,
                        );
                      }
                    },
                    child: const Text('Next')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///[return widget for Signup Step Six]
  Widget _buildFinishSection() {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        if (provider.status == AuthStatus.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.status == AuthStatus.UNAUTHENTICATED) {
          Fluttertoast.showToast(
              msg: provider.error, toastLength: Toast.LENGTH_LONG);
          return child;
        } else if (provider.status == AuthStatus.AUTHENTICATED) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomeScreen()));
          });
          return const SizedBox.shrink();
        } else {
          return child;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //back icon
              InkWell(
                onTap: () => _pageController.animateToPage(
                  3,
                  duration: _pageTransitionDuration,
                  curve: _pageAnimationCurve,
                ),
                child: SvgPicture.asset(
                  Assets.BACK,
                ),
              ),
              //header space
              SizedBox(height: screenSize.height * 0.1),
              //heading text
              SizedBox(
                width: screenSize.width * 0.4,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '''
Let's Finish''',
                    style: textTheme.headline1,
                  ),
                ),
              ),
              //subtitle text
              SizedBox(
                width: screenSize.width * 0.6,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Click on register',
                    style: textTheme.subtitle1,
                  ),
                ),
              ),
              //spacing
              SizedBox(
                height: screenSize.height * 0.08,
              ),

              //spacing
              SizedBox(height: screenSize.height * 0.06),

              //login button
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: screenSize.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () async {
                      //unfocusing
                      FocusScope.of(context).unfocus();

                      //verification step 5
                      //   final form = _formKeyStepFour.currentState;

                      // if (form.validate()) {
                      //   form.save();

                      authProvider.signupUserWithEmail(_email, _password);
                      // } else {
                      //   //Phone verification is unsuccessful.
                      // }
                    },
                    child: const FittedBox(child: Text('Register')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
