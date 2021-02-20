import 'package:flutter/cupertino.dart';
import 'package:shopapp/services/products_service.dart';
import 'package:shopapp/models/product.dart';

class AppProvider with ChangeNotifier{
  List<Product> _featuredProducts = [];
  List<Product> get featuredProducts => _featuredProducts;

  ProductsService _productsService = ProductsService();

  void getFeaturedProducts() async {
    _featuredProducts = await _productsService.getFeaturedProducts();
    notifyListeners();
  }

}