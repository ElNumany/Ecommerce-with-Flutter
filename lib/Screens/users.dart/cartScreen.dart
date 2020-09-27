import 'package:flutter/material.dart';
import 'package:mycontact/Models/product.dart';
import 'package:mycontact/Provider/cartItems.dart';
import 'package:mycontact/Screens/users.dart/productinfo.dart';
import 'package:mycontact/const.dart';
import 'package:mycontact/services/store.dart';
import 'package:mycontact/widgets/cusomMenu.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text(
          'My Cart',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: kMainColor,
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight -
                    statusbarHeight -
                    appBarHeight -
                    (screenHeight * .08),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(details, context, products[index]);
                        },
                        child: Container(
                          height: screenHeight * .15,
                          color: kTextboxColor,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(products[index].pLocation),
                                radius: screenHeight * .15 / 2,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '\$ ${products[index].pPrice}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        products[index].pQuantity.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                height: screenHeight -
                    (screenHeight * .08) -
                    statusbarHeight -
                    appBarHeight,
                child: Center(
                  child: Text("Cart Is Empty".toUpperCase()),
                ),
              );
            }
          }),
          Builder(
            builder: (context) => ButtonTheme(
              minWidth: screenwidth * .5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: RaisedButton(
                onPressed: () {
                  showCastomDialog(products, context);
                },
                child: Text('Order'.toUpperCase()),
                color: kMainColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    {
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
                Navigator.pop(context);
                Provider.of<CartItem>(context, listen: false)
                    .deleteProduct(product);
                Navigator.pushNamed(context, ProductInfo.id,
                    arguments: product);
              },
            ),
            MyPopupMenuItem(
              onClick: () async {
                Navigator.pop(context);
                Provider.of<CartItem>(context, listen: false)
                    .deleteProduct(product);
              },
              child: Text('delete'),
            ),
          ]);
    }
  }

  void showCastomDialog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrders(
                  {kTotalPrice: price, kAddress: address}, products);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Order Successfully added")));
              Navigator.pop(context);
            } catch (e) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Theres Error please reorder Correctly!! $e")));
              Navigator.pop(context);
            }
          },
          child: Text('Order now'),
        )
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: "Write your Address!"),
      ),
      title: Text("Total Price = $price"),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
