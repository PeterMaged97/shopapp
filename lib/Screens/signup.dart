import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Screens/home_page.dart';
import 'package:shopapp/Screens/loading.dart';
import 'package:shopapp/Screens/login.dart';
import 'package:shopapp/auth/auth.dart';
import 'package:shopapp/services/user_service.dart';
import 'package:shopapp/provider/user_provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _confirmPasswordEditingController =
      TextEditingController();
  TextEditingController _nameController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  Auth auth = Auth();

  @override
  void initState() {
    super.initState();
  }

  Future<void> validateForm() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      print('valid');
      //await registerUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          Hero(
            tag: 'bg',
            child: Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/back.jpg'),
                fit: BoxFit.cover,
              )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                //alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.70),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.person),
                              ),
                            ),
                            controller: _nameController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.70),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.email),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailEditingController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter your email address';
                              } else {
                                Pattern pattern =
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?)*$";
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.70),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                suffixIcon: GestureDetector(
                                  child: Icon(Icons.remove_red_eye),
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.lock),
                                )),
                            controller: _passwordEditingController,
                            obscureText: !showPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'You must enter a password';
                              } else if (value.length < 6) {
                                return 'Your password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.70),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                suffixIcon: GestureDetector(
                                  child: Icon(Icons.remove_red_eye),
                                  onTap: () {
                                    setState(() {
                                      showConfirmPassword =
                                          !showConfirmPassword;
                                    });
                                  },
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.lock),
                                )),
                            controller: _confirmPasswordEditingController,
                            obscureText: !showConfirmPassword,
                            validator: (value) {
                              if (value != _passwordEditingController.text) {
                                return 'Password does\'t match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.deepOrange,
                          child: MaterialButton(
                            onPressed: ()async{
                              if(_formKey.currentState.validate()){
                                if(!await user.signUp(_nameController.text, _emailEditingController.text, _passwordEditingController.text)){
                                  _key.currentState.showSnackBar(SnackBar(content: Text('Sign up failed'),));
                                }
                              }
                            },
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            child: Text('Register'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            children: [
                              TextSpan(text: 'Sign In', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red), recognizer: TapGestureRecognizer()..onTap = () {
                                Provider.of<UserProvider>(context, listen: false).setUninitialized();
                              }),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.red[800],
                          child: MaterialButton(
                            onPressed: () {},
                            textColor: Colors.white,
                            //minWidth: double.infinity,
                            child: Text('Sign up using Google'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: loading,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
