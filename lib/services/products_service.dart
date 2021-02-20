import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/models/product.dart';

class ProductsService{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'products';

  Future<List<Product>> getFeaturedProducts(){
    return _firestore.collection(collection).where('featured', isEqualTo: 'true').get().then((snaps) {
      List<Product> featuredProducts = [];
      snaps.docs.map((snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
      return featuredProducts;
    });
  }

}