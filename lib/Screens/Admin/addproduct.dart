import 'package:flutter/material.dart';

import 'package:mycontact/Models/product.dart';
import 'package:mycontact/const.dart';
import 'package:mycontact/services/store.dart';
import 'package:mycontact/widgets/cusomtextfield.dart';

class AddProduct extends StatelessWidget {
  static String id = "AddProduct";
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _name, _price, _description, _category, _imageLocation;
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
                hint: "Product Name",
                icon: null,
                onClick: (value) {
                  _name = value;
                }),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                hint: "Product Price",
                icon: null,
                onClick: (value) {
                  _price = value;
                }),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                hint: "Product Description",
                icon: null,
                onClick: (value) {
                  _description = value;
                }),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                hint: "Product Category",
                icon: null,
                onClick: (value) {
                  _category = value.trim();
                }),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                hint: "Product Location",
                icon: null,
                onClick: (value) {
                  _imageLocation = value.trim();
                }),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                color: kTextboxColor,
                child: Text(
                  "Add proudct",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_globalKey.currentState.validate()) {
                    _globalKey.currentState.save();
                    _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pCategory: _category,
                      pDescription: _description,
                      pLocation: _imageLocation,
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
