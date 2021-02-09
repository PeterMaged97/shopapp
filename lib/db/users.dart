import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  FirebaseFirestore __firestore = FirebaseFirestore.instance;
  String ref =  'users';

  createUser(Map user){
    __firestore.collection(ref).doc(user['userID']).set(user);
  }

}