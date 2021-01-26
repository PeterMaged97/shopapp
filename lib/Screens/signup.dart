import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Screens/home_page.dart';
import 'package:shopapp/db/users.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey _formKey = GlobalKey<FormState>();
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

  @override
  void initState() {
    super.initState();
  }

  Future<void> validateForm() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      print('valid');
      await registerUser();
    }
  }

  Future<void> registerUser() async {
    User firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      print('Successful');
      try {
        UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _emailEditingController.text,
            password: _passwordEditingController.text
        );
        _userServices.createUser({
          'name': _nameController.text,
          'mail': user.user.email,
          'id': user.user.uid,
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(firebaseAuth: _firebaseAuth,)));
      } catch(signUpError) {
        //TODO : handle different kinds of sign up errors not just email collisions
        print(signUpError);
        Fluttertoast.showToast(msg: 'This email has already been used.', toastLength: Toast.LENGTH_LONG);
      }
    }else{
      print(firebaseUser.displayName);
      print(firebaseUser.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    //alignment: Alignment.topCenter,
                    child: Image.asset('images/lg.png',
                        //width: 250,
                        height: 100,
                        fit: BoxFit.cover),
                  ),
                ),
              ),

              //SizedBox(height: 100,),
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
                          color: Colors.red[800],
                          child: MaterialButton(
                            onPressed: () async {
                              await validateForm();
                            },
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            child: Text('Register'),
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
