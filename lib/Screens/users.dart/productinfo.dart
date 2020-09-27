import 'package:flutter/material.dart';
import 'package:mycontact/Models/product.dart';
import 'package:mycontact/Provider/cartItems.dart';
import 'package:mycontact/Screens/users.dart/cartScreen.dart';
import 'package:mycontact/const.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage(product.pLocation),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0001),
          child: Material(
            color: kMainColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                color: kMainColor,
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, CartScreen.id);
                        },
                        child: Icon(Icons.shopping_cart)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Column(
            children: <Widget>[
              Opacity(
                opacity: .5,
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.pName,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.pDescription,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          product.pPrice,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: Colors.red),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: add,
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              _quantity.toString(),
                              style: TextStyle(fontSize: 50),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: subtract,
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Builder(
                  builder: (context) => RaisedButton(
                    onPressed: () {
                      addTocart(context, product);
                    },
                    child: Text(
                      'Add To Cart'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    color: kMainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  void addTocart(context, product) {
    CartItem cartitem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartitem.products;
    for (var productsInCart in productsInCart) {
      if (productsInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      cartitem.addproduct(product);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('This item added Before!')));
    } else {
      cartitem.addproduct(product);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Added To Cart')));
    }
  }
}
