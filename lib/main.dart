import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycontact/Provider/cartItems.dart';
import 'package:mycontact/Provider/modelhud.dart';
import 'package:mycontact/Screens/Admin/AdminHome/adminhome.dart';
import 'package:mycontact/Screens/Admin/addproduct.dart';
import 'package:mycontact/Screens/Admin/editproduct.dart';
import 'package:mycontact/Screens/Admin/mangeProducts.dart';
import 'package:mycontact/Screens/Admin/orderDetails.dart';
import 'package:mycontact/Screens/Admin/orderScreen.dart';
import 'package:mycontact/Screens/signupScree.dart';
import 'package:mycontact/Screens/users.dart/cartScreen.dart';
import 'package:mycontact/Screens/users.dart/homepage.dart';
import 'package:mycontact/Screens/users.dart/productinfo.dart';
import 'package:mycontact/const.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/adminmode.dart';
import 'Screens/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("Wait!"),
                ),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data.getBool(kkeepmeLoggerIn) ?? false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => Modelhud(),
                ),
                ChangeNotifierProvider(
                  create: (context) => AdminMode(),
                ),
                ChangeNotifierProvider(
                  create: (context) => CartItem(),
                ),
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: isUserLoggedIn ? HomePage.id : LoginScreen.id,
                  routes: {
                    LoginScreen.id: (context) => LoginScreen(),
                    Signup.id: (context) => Signup(),
                    AdminHome.id: (context) => AdminHome(),
                    HomePage.id: (context) => HomePage(),
                    AddProduct.id: (context) => AddProduct(),
                    MangeProduct.id: (context) => MangeProduct(),
                    EditProduct.id: (context) => EditProduct(),
                    ProductInfo.id: (context) => ProductInfo(),
                    CartScreen.id: (context) => CartScreen(),
                    OrderScreen.id: (context) => OrderScreen(),
                    OrderDetails.id: (context) => OrderDetails(),
                  }),
            );
          }
        });
  }
}
