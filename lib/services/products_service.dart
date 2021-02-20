import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/models/product.dart';

class ProductsService{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'products';

  Future<List<Product>> getFeaturedProducts(){
    return _firestore.collection(collection).where('featured', isEqualTo: true).get().then((snaps) {
      List<Product> featuredProducts = [];
      //snaps.docs.map((snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
      for (QueryDocumentSnapshot product in snaps.docs){
        Product p = Product.fromSnapshot(product);
        featuredProducts.add(p);
      }
      print(featuredProducts);
      return featuredProducts;
    });
  }

  Future<List<Product>> getProducts(){
    print('getting products');
    return _firestore.collection(collection).get().then((snaps) {
      List<Product> products = [];
      for (QueryDocumentSnapshot product in snaps.docs){
        Product p = Product.fromSnapshot(product);
        products.add(p);
      }
      snaps.docs.map((snapshot) => products.add(Product.fromSnapshot(snapshot)));
      print(products);
      return products;
    });
  }

  Future<List<Product>> searchProducts(String productName){

    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy('name')
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<Product> products = [];
          for(DocumentSnapshot product in result.docs){
            products.add(Product.fromSnapshot(product));
          }
          return products;
    });
  }

}