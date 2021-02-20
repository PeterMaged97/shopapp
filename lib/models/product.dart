import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  static const String kBrand = 'brand';
  static const String kCategory = 'category';
  static const String kFeatured = 'featured';
  static const String kImageURL = 'images';
  static const String kName = 'name';
  static const String konSale = 'on sale';
  static const String kPrice = 'price';
  static const String kQuantity = 'quantity';
  static const String kSizes = 'sizes';
  static const String kId = 'id';

  String _brand;
  String _category;
  bool _featured;
  bool _onSale;
  String _imageURL;
  List<String> _sizes;
  int _quantity;
  double _price;
  String _name;
  String _id;

  String get brand => _brand;
  String get category => _category;
  bool get featured => _featured;
  bool get onSale => _onSale;
  String get image => _imageURL;
  List<String> get sizes => _sizes;
  int get quantity => _quantity;
  double get price => _price;
  String get name => _name;
  String get id => _id;

  Product.fromSnapshot(DocumentSnapshot snapshot){
    _featured = snapshot.data()[kFeatured];
    _brand = snapshot.data()[kBrand];
    _category = snapshot.data()[kCategory];
    _onSale = snapshot.data()[konSale];
    _imageURL = snapshot.data()[kImageURL];
    _sizes = snapshot.data()[kSizes];
    _quantity = snapshot.data()[kQuantity];
    _price = snapshot.data()[kPrice];
    _name = snapshot.data()[kName];
    _id = snapshot.data()[kId];
  }

}