import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth{
  Future<User> googleSignIn();
}

class Auth implements BaseAuth{
  final GoogleSignIn googleSingIn = GoogleSignIn();
  @override
  Future<User> googleSignIn() async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignInAccount googleAccount = await googleSingIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    final AuthCredential creds = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken, accessToken: googleAuth.accessToken,
    );
    try{
      UserCredential userCreds = await _firebaseAuth.signInWithCredential(creds);
      return userCreds.user;
    }catch(e){
      print(e);
      return null;
    }
  }
}