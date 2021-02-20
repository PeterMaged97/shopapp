import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  static const String kId = 'uid';
  static const String kEmail = 'email';
  static const String kName = 'name';
  static const String kStripeId = 'stripeId';

  String _name;
  String _email;
  String _id;
  String _stripedId;

  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripedId => _stripedId;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.data()[kName];
    _email = snapshot.data()[kEmail];
    _id = snapshot.data()[kId];
    _stripedId = snapshot.data()[kStripeId] ?? '';
  }
}