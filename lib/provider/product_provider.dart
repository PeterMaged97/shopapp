import 'package:flutter/cupertino.dart';
import 'package:shopapp/services/products_service.dart';
import 'package:shopapp/models/product.dart';

class ProductProvider with ChangeNotifier{
  ProductsService _productsService = ProductsService();
  List<Product> _featuredProducts = [];
  List<Product> products = [];
  List<Product> productsSearched = [];
  List<Product> get featuredProducts => _featuredProducts;

  ProductProvider(){
    loadProducts();
    getFeaturedProducts();
  }

  void getFeaturedProducts() async {
    _featuredProducts = await _productsService.getFeaturedProducts();
    notifyListeners();
  }

  void loadProducts() async{
    products = await _productsService.getProducts();
    notifyListeners();
  }

}