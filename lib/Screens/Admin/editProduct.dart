import 'package:flutter/material.dart';
import 'package:mycontact/Models/product.dart';
import 'package:mycontact/services/store.dart';
import 'package:mycontact/widgets/cusomtextfield.dart';

import '../../const.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _name, _price, _description, _category, _imageLocation;
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    Product products = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .2),
              Column(
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
                        _category = value;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      hint: "Product Location",
                      icon: null,
                      onClick: (value) {
                        _imageLocation = value;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                      color: kTextboxColor,
                      child: Text(
                        "Edit proudct",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          _store.editProduct(
                              ({
                                KProductName: _name,
                                KProductLocation: _imageLocation,
                                KProductCategory: _category,
                                KProductDescription: _description,
                                KProductPrice: _price,
                              }),
                              products.pID);
                        }
                      }),
                ],
              ),
            ],
          )),
    );
  }
}
