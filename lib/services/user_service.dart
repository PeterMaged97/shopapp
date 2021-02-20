import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/models/user.dart';

class UserServices{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref =  'users';

  void createUser(Map<String, dynamic> userData){
    _firestore.collection(ref).doc(userData['userID']).set(userData);
  }

  Future<UserModel> getUserById(String id)=>_firestore.collection(ref).doc(id).get().then((doc) {
    return UserModel.fromSnapshot(doc);
  });

}