import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/constants.dart';
import 'package:shoe_shop/widgets/custom_button.dart';
import 'package:shoe_shop/widgets/custom_inputs.dart';

class RegisterPage extends StatefulWidget {
  // Building an alert dialog box to display some error
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                child: Text('Close DialodBox'))
          ],
        );
      },
    );
  }

  //Creating a new user account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registeremail, password: _registerpassword);
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
      _registerFormLoading = true;
    });

    // Running the create account method
    String _createAccountFeedback = await _createAccount();

    // If the string is not null, we get error while creating account.
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      //setting the form to regular state[not loading]
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerFormLoading = false;

  String _registeremail = "";
  String _registerpassword = "";

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
                  'Create A New Account',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: 'Email..',
                    onChanged: (value) {
                      _registeremail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: 'Password',
                    onChanged: (value) {
                      _registerpassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomButton(
                    text: 'Create New Account',
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _registerFormLoading,
                    outlineBtn: true,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CustomButton(
                  text: 'Back To Login Page',
                  onPressed: () {
                    Navigator.pop(context);
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
