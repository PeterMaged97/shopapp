import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Screens/home_page.dart';
import 'package:shopapp/Screens/loading.dart';
import 'package:shopapp/Screens/signup.dart';
import 'package:shopapp/provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;
  bool showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => isSignedIn());
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    //alignment: Alignment.topCenter,
                    child: Image.asset(
                      'images/lg.png',
                      //width: 250,
                      height: 100,
                      fit: BoxFit.cover
                    ),
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
                          borderRadius: BorderRadius.circular(15.0),
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
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white.withOpacity(0.70),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                suffixIcon: GestureDetector(child: Icon(Icons.remove_red_eye), onTap: (){
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },),
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
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.red[800],
                          child: MaterialButton(
                            onPressed: ()async{
                              if(_formKey.currentState.validate()){
                                if(!await user.signIn(_emailEditingController.text, _passwordEditingController.text)){
                                  _key.currentState.showSnackBar(SnackBar(content: Text('Sign in failed'),));
                                }
                              }
                          },
                          textColor: Colors.white,
                          minWidth: double.infinity,
                          child: Text('Login'),),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('Don\'t have an account?', style: TextStyle(fontSize: 16, color: Colors.white),),
                        InkWell(child: Text(' Sign up here', style: TextStyle(fontSize: 16, color: Colors.red),),
                        onTap: (){
                          Provider.of<UserProvider>(context, listen: false).setUnregistered();
                        },)
                      ],)
                    ],
                  ),
                ),
              ),
              Container(
                //alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Divider(color: Colors.white,),
                    Text('Other login options', style: TextStyle(color: Colors.white, fontSize: 16)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.red,
                        child: MaterialButton(
                          onPressed: (){},
                          textColor: Colors.white,
                          minWidth: double.infinity,
                          child: Text('Google'),),
                      ),
                    )
                  ],
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
