import 'package:flutter/material.dart';
import 'package:macro_bank/components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:macro_bank/constants.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'MacroBank',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[400],
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: kTextFieldDecoration.copyWith(
                    hintStyle: TextStyle(color: Colors.white),
                  )
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                style: TextStyle(color: Colors.white),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.deepPurple[400],
                title: 'Log in',
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    //This is an asynchronous firebase call that checks the authentication of the user
                    //If the user can be successfully authenticated, then they will proceed to the home screen.
                    final returningUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (returningUser != null) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    spinner = false;
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
