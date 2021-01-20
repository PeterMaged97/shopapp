import 'package:firebase_database/firebase_database.dart';

class UserServices{
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref =  'users';

  createUser(Map user){
    _database.reference().child(ref).push().set(user).catchError((e) => {print(e)});
  }

}