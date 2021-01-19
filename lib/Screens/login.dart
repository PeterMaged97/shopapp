import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Screens/home_page.dart';
import 'package:shopapp/Screens/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
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
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.lock),
                                )),
                            controller: _passwordEditingController,
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
                          child: MaterialButton(onPressed: (){},
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
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
                          onPressed: signInWithGoogle,
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

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLoggedIn = await _googleSignIn.isSignedIn();

    if (isLoggedIn) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(_googleSignIn)));
    }
    setState(() {
      loading = false;
    });
  }

  Future signInWithGoogle() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'id': user.uid,
          'username': user.displayName,
          'profile_picture': user.photoURL,
        });
        await preferences.setString('id', user.uid);
        await preferences.setString('username', user.displayName);
        await preferences.setString('profile_picture', user.photoURL);
      } else {
        await preferences.setString('id', documents[0]['id']);
        await preferences.setString('username', documents[0]['username']);
        await preferences.setString(
            'profile_picture', documents[0]['profile_picture']);
      }
      Fluttertoast.showToast(msg: 'Welcome ${user.displayName}');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(_googleSignIn)));
    } else {
      Fluttertoast.showToast(msg: "Login failed");
    }
    setState(() {
      loading = false;
    });
  }
}
