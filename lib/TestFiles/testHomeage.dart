// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mycontact/Models/product.dart';
// import 'package:mycontact/const.dart';
// import 'package:mycontact/services/auth.dart';
// import 'package:mycontact/services/store.dart';
// import 'package:mycontact/widgets/productView.dart';

// import '../functions.dart';

// class HomePage extends StatefulWidget {
//   static String id = 'HomePage';

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _auth = Auth();
//   final _store = Store();
//   int _tabBarIndex = 0;
//   int _bottomBarIndex = 0;
//   List<Product> _products;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         DefaultTabController(
//           length: 4,
//           child: Scaffold(
//             bottomNavigationBar: BottomNavigationBar(
//                 currentIndex: _bottomBarIndex,
//                 fixedColor: kTextboxColor,
//                 unselectedItemColor: kMainColor,
//                 onTap: (value) {
//                   setState(() {
//                     _bottomBarIndex = value;
//                   });
//                 },
//                 items: [
//                   BottomNavigationBarItem(
//                       title: Text('data'), icon: Icon(Icons.person)),
//                   BottomNavigationBarItem(
//                       title: Text('data'), icon: Icon(Icons.person)),
//                   BottomNavigationBarItem(
//                       title: Text('data'), icon: Icon(Icons.person)),
//                   BottomNavigationBarItem(
//                       title: Text('data'), icon: Icon(Icons.person)),
//                 ]),
//             appBar: AppBar(
//               backgroundColor: kMainColor,
//               elevation: 0,
//               bottom: TabBar(
//                 indicatorColor: kTextboxColor,
//                 onTap: (value) {
//                   setState(() {
//                     _tabBarIndex = value;
//                   });
//                 },
//                 tabs: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(1),
//                     child: Text(
//                       'ٍStudents Tools',
//                       style: TextStyle(
//                         color:
//                             _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
//                         fontSize: (_tabBarIndex == 0 ? 16 : null),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Students Activity',
//                     style: TextStyle(
//                       color: _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
//                       fontSize: _tabBarIndex == 1 ? 14 : null,
//                     ),
//                   ),
//                   Text(
//                     'Plays',
//                     style: TextStyle(
//                       color: _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
//                       fontSize: _tabBarIndex == 2 ? 16 : null,
//                     ),
//                   ),
//                   Text(
//                     'Another Services',
//                     style: TextStyle(
//                       color: _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
//                       fontSize: _tabBarIndex == 3 ? 16 : null,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             body: TabBarView(children: <Widget>[
//               studentsToolsMethod(),
//               studentsActivityMethod(),
//               ProductsMethod(kProductCategoryStudentsPlays, _products),
//               ProductsMethod(kProductCategoryServices, _products),
//             ]),
//           ),
//         ),
//         Material(
//           color: kMainColor,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//             child: Container(
//               color: kMainColor,
//               height: MediaQuery.of(context).size.height * .1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Discover'.toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Icon(Icons.shopping_cart),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget studentsToolsMethod() {
//     return StreamBuilder<QuerySnapshot>(
//         stream: _store.loadProduct(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Product> products = [];
//             for (var doc in snapshot.data.documents) {
//               var data = doc.data;

//               products.add(Product(
//                   pID: doc.documentID,
//                   pPrice: data[KProductPrice],
//                   pName: data[KProductName],
//                   pDescription: data[KProductDescription],
//                   pLocation: data[KProductLocation],
//                   pCategory: data[KProductDescription]));
//             }
//             _products = [...products];
//             products.clear();
//             products =
//                 getProductCategory(kProductCategoryStudentsTools, _products);
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, childAspectRatio: .8),
//               itemBuilder: (context, index) => Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: GestureDetector(
//                   child: Stack(
//                     children: <Widget>[
//                       Positioned.fill(
//                         child: Image(
//                           fit: BoxFit.fill,
//                           image: AssetImage(products[index].pLocation),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         child: Opacity(
//                           opacity: 0.6,
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             color: Colors.white,
//                             height: 60,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(products[index].pName,
//                                       style: TextStyle(
//                                           color: kMainColor, fontSize: 15)),
//                                   Text("\$ ${products[index].pPrice}",
//                                       style: TextStyle(
//                                           color: Colors.red, fontSize: 15)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               itemCount: products.length,
//             );
//           } else {
//             return Text("Wait! .. Your have bad connection! ");
//           }
//         });
//   }

//   Widget studentsActivityMethod() {
//     List<Product> products;
//     products = getProductCategory(kProductCategoryStudentsActivity, products);
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, childAspectRatio: .8),
//       itemBuilder: (context, index) => Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: GestureDetector(
//           child: Stack(
//             children: <Widget>[
//               Positioned.fill(
//                 child: Image(
//                   fit: BoxFit.fill,
//                   image: AssetImage(products[index].pLocation),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: Opacity(
//                   opacity: 0.6,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.white,
//                     height: 60,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(products[index].pName,
//                               style:
//                                   TextStyle(color: kMainColor, fontSize: 15)),
//                           Text("\$ ${products[index].pPrice}",
//                               style:
//                                   TextStyle(color: Colors.red, fontSize: 15)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       itemCount: products.length,
//     );
//   }
// }
