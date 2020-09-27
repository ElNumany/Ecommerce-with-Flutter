import 'package:flutter/widgets.dart';
import 'package:mycontact/Models/product.dart';

class CartItem extends ChangeNotifier {
  List<Product> products = [];
  addproduct(Product product) {
    products.add(product);

    notifyListeners();
  }

  deleteProduct(Product product) {
    products.remove(product);
    notifyListeners();
  }
}
