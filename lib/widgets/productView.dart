// import "package:flutter/material.dart";
// import 'package:mycontact/Models/product.dart';

// import '../const.dart';
// import '../functions.dart';

// Widget ProductsMethod(String pCategory, List<Product> allProducts) {
//   List<Product> products;
//   products = getProductCategory(pCategory, allProducts);
//   return GridView.builder(
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2, childAspectRatio: .8),
//     itemBuilder: (context, index) => Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: GestureDetector(
//         child: Stack(
//           children: <Widget>[
//             Positioned.fill(
//               child: Image(
//                 fit: BoxFit.fill,
//                 image: AssetImage(products[index].pLocation),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               child: Opacity(
//                 opacity: 0.6,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   color: Colors.white,
//                   height: 60,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(products[index].pName,
//                             style: TextStyle(color: kMainColor, fontSize: 15)),
//                         Text("\$ ${products[index].pPrice}",
//                             style: TextStyle(color: Colors.red, fontSize: 15)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//     itemCount: products.length,
//   );
// }
