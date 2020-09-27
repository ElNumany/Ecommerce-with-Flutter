import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycontact/Models/product.dart';
import 'package:mycontact/const.dart';

class Store {
  final Firestore _fireStore = Firestore.instance;
  /////////***************/////////////////////
  //Add Product To Firebase!

  addProduct(Product product) {
    _fireStore.collection(KProductCollection).add({
      KProductName: product.pName,
      KProductPrice: product.pPrice,
      KProductDescription: product.pDescription,
      KProductLocation: product.pLocation,
      KProductCategory: product.pCategory,
    });
  }

  /////////***************/////////////////////
  //Load Product from firebase

  Stream<QuerySnapshot> loadProduct() {
    return _fireStore.collection(KProductCollection).snapshots();
  }

  /////////***************/////////////////////
  //Edit Product from firebase
  editProduct(data, documentid) {
    _fireStore
        .collection(KProductCollection)
        .document(documentid)
        .updateData(data);
  }

  /////////***************/////////////////////
  //Delete Product from firebase
  deleteProduct(documentid) {
    _fireStore.collection(KProductCollection).document(documentid).delete();
  }

  /////////***************/////////////////////
  //Store Orders To firebase
  storeOrders(data, List<Product> products) {
    var documentRef = _fireStore.collection(kOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(kOrdersDetails).document().setData({
        KProductName: product.pName,
        KProductPrice: product.pPrice,
        KProductLocation: product.pLocation,
        kQuantity: product.pQuantity,
        KProductCategory: product.pCategory,
      });
    }
  }

  /////////***************/////////////////////
  //Load Orders From firebase
  Stream<QuerySnapshot> loadOrders() {
    return _fireStore.collection(kOrders).snapshots();
  }

  /////////***************/////////////////////
  //Load Orders Details From firebase
  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _fireStore
        .collection(kOrders)
        .document(documentId)
        .collection(kOrdersDetails)
        .snapshots();
  }
}
