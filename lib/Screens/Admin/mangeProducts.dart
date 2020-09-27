import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycontact/Models/product.dart';
import 'package:mycontact/Screens/Admin/editProduct.dart';
import 'package:mycontact/const.dart';
import 'package:mycontact/services/store.dart';
import 'package:mycontact/widgets/cusomMenu.dart';

class MangeProduct extends StatefulWidget {
  static String id = 'MangeProduct';

  @override
  _MangeProductState createState() => _MangeProductState();
}

class _MangeProductState extends State<MangeProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
                  pID: doc.documentID,
                  pPrice: data[KProductPrice],
                  pName: data[KProductName],
                  pCategory: data[KProductCategory],
                  pDescription: data[KProductDescription],
                  pLocation: data[KProductLocation],
                ));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .8),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTapUp: (details) async {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx1 = MediaQuery.of(context).size.width - dx;
                      double dy1 = MediaQuery.of(context).size.width - dy;

                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
                          items: [
                            MyPopupMenuItem(
                              child: Text("Edit"),
                              onClick: () {
                                Navigator.pushNamed(context, EditProduct.id,
                                    arguments: products[index]);
                              },
                            ),
                            MyPopupMenuItem(
                              onClick: () async {
                                await _store.deleteProduct(products[index].pID);
                              },
                              child: Text('delete'),
                            ),
                          ]);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(products[index].pLocation),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(products[index].pName,
                                        style: TextStyle(
                                            color: kMainColor, fontSize: 15)),
                                    Text("\$ ${products[index].pPrice}",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 15)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: products.length,
              );
            } else {
              return Text("Wait! .. Your have bad connection! ");
            }
          }),
    );
  }
}
