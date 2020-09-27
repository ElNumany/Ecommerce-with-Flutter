import 'package:flutter/material.dart';
import 'package:mycontact/Screens/Admin/addproduct.dart';
import 'package:mycontact/Screens/Admin/mangeProducts.dart';
import 'package:mycontact/Screens/Admin/orderScreen.dart';
import 'package:mycontact/const.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';

  @override
  Widget build(BuildContext context) {
    // double heigt = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            color: kTextboxColor,
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text(
              "Add Product",
              style: TextStyle(color: Colors.white),
            ),
          ),
          RaisedButton(
            color: kTextboxColor,
            onPressed: () {
              Navigator.pushNamed(context, MangeProduct.id);
            },
            child: Text("Edit Product", style: TextStyle(color: Colors.white)),
          ),
          RaisedButton(
            color: kTextboxColor,
            onPressed: () {
              Navigator.pushNamed(context, OrderScreen.id);
            },
            child: Text("View Orders", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
