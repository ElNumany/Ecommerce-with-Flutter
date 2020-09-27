import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycontact/Models/product.dart';
import 'package:mycontact/Screens/loginScreen.dart';
import 'package:mycontact/Screens/users.dart/cartScreen.dart';
import 'package:mycontact/Screens/users.dart/productinfo.dart';
import 'package:mycontact/const.dart';
import 'package:mycontact/services/auth.dart';
import 'package:mycontact/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  final _store = Store();
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _bottomBarIndex,
                fixedColor: kTextboxColor,
                unselectedItemColor: kMainColor,
                onTap: (value) async {
                  if (value == 2) {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                    await _auth.signOutt();
                    Navigator.popAndPushNamed(context, LoginScreen.id);
                  }
                  setState(() {
                    _bottomBarIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      title: Text('Home Page'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('data'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text(
                        'Sign out',
                        style: TextStyle(color: Colors.red),
                      ),
                      icon: Icon(Icons.close, color: Colors.red)),
                ]),
            appBar: AppBar(
              backgroundColor: kMainColor,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kTextboxColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Text(
                      'ٍStudents Tools',
                      style: TextStyle(
                        color:
                            _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                        fontSize: (_tabBarIndex == 0 ? 16 : null),
                      ),
                    ),
                  ),
                  Text(
                    'Students Activity',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 14 : null,
                    ),
                  ),
                  Text(
                    'Plays',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Another Services',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
              studentsToolsMethod(),
              studentsActivityMethod(),
              playsMethod(),
              anotherServices(),
            ]),
          ),
        ),
        Material(
          color: kMainColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              color: kMainColor,
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
      ],
    );
  }

  Widget studentsToolsMethod() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (doc[KProductCategory] == kProductCategoryStudentsTools) {
                products.add(Product(
                    pID: doc.documentID,
                    pPrice: data[KProductPrice],
                    pName: data[KProductName],
                    pDescription: data[KProductDescription],
                    pLocation: data[KProductLocation],
                    pCategory: data[KProductDescription]));
              }
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
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
        });
  }

  studentsActivityMethod() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (doc[KProductCategory] == kProductCategoryStudentsActivity) {
                products.add(Product(
                    pID: doc.documentID,
                    pPrice: data[KProductPrice],
                    pName: data[KProductName],
                    pDescription: data[KProductDescription],
                    pLocation: data[KProductLocation],
                    pCategory: data[KProductDescription]));
              }
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
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
        });
  }

  playsMethod() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (doc[KProductCategory] == kProductCategoryStudentsPlays) {
                products.add(Product(
                    pID: doc.documentID,
                    pPrice: data[KProductPrice],
                    pName: data[KProductName],
                    pDescription: data[KProductDescription],
                    pLocation: data[KProductLocation],
                    pCategory: data[KProductDescription]));
              }
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
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
        });
  }

  anotherServices() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (doc[KProductCategory] == kProductCategoryServices) {
                products.add(Product(
                    pID: doc.documentID,
                    pPrice: data[KProductPrice],
                    pName: data[KProductName],
                    pDescription: data[KProductDescription],
                    pLocation: data[KProductLocation],
                    pCategory: data[KProductDescription]));
              }
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
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
        });
  }
}

// @override
// void initState() {
//   getCurrentUser();
// }

// getCurrentUser() async {
//   _loggedUser = await _auth.getUser();
// }
