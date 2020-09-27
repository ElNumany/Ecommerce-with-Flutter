import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycontact/Models/order.dart';
import 'package:mycontact/Screens/Admin/orderDetails.dart';
import 'package:mycontact/const.dart';
import 'package:mycontact/services/store.dart';

class OrderScreen extends StatelessWidget {
  static String id = "Order Screen";
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("There Is No Orders"),
            );
          } else {
            List<Order> order = [];
            for (var doc in snapshot.data.documents) {
              order.add(Order(
                documentID: doc.documentID,
                totalPrice: doc.data[kTotalPrice],
                address: doc.data[kAddress],
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: kTextboxColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, OrderDetails.id,
                            arguments: order[index].documentID);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Price = \$${order[index].totalPrice}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Address = ${order[index].address}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: order.length,
            );
          }
        },
      ),
    );
  }
}
