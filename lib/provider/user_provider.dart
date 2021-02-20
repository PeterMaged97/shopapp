import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/user.dart';
import 'package:shopapp/services/user_service.dart';

enum Status {Uninitialized, Authenticated, Authenticating, Unauthenticated, Unregistered}

class UserProvider with ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential _userCredential;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserModel _userModel;

  //Getters
  UserModel get userModel => _userModel;
  Status get status => _status;
  UserCredential get userCredential => _userCredential;
  UserServices get userServices => _userServices;

  UserProvider.initialize(): auth = FirebaseAuth.instance{
    auth.authStateChanges().listen((_onStateChanged) { });
  }

  Future setUnregistered(){
    _status = Status.Unregistered;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future setUninitialized(){
    _status = Status.Uninitialized;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> signIn(String email, String password) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await auth.signInWithEmailAndPassword(email: email, password: password).whenComplete(() => _status = Status.Authenticated);
      notifyListeners();
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
        Map<String, dynamic> userData = {
          'name': name,
          'email': email,
          'userID': user.user.uid
        };
        UserServices().createUser(userData);
      }).whenComplete(() => signIn(email, password));
      print(_status);
      notifyListeners();
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async{
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);

  }

  Future<void> _onStateChanged(UserCredential uc) async{
    User user = uc.user;
    if(user == null){
      _status = Status.Unauthenticated;
    }else{
      _userCredential = uc;
      _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

}
