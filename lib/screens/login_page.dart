import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/constants.dart';
import 'package:shoe_shop/screens/register_page.dart';
import 'package:shoe_shop/widgets/custom_button.dart';
import 'package:shoe_shop/widgets/custom_inputs.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Container(
            child: Text(error),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close DialogBox'))
          ],
        );
      },
    );
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginemail, password: _loginpassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The Password Provided is too weak.';
      } else if (e.code == 'email already in use') {
        return 'The account already exists for the email.';
      }

      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    // setting the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    // Running the create account method
    String _loginAccountFeedback = await _loginAccount();

    // If the string is not null, we get error while creating account.
    if (_loginAccountFeedback != null) {
      _alertDialogBuilder(_loginAccountFeedback);

      //setting the form to regular state[not loading]
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  bool _loginFormLoading = false;

  String _loginemail = "";
  String _loginpassword = "";

  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode;
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Text(
                  'Welcome User,\nLogin to your account',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: 'Email..',
                    onChanged: (value) {
                      _loginemail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: 'Password',
                    onChanged: (value) {
                      _loginpassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _loginFormLoading,
                    outlineBtn: true,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CustomButton(
                  text: 'Create New Account',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ));
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
