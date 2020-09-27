import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mycontact/Provider/adminmode.dart';
import 'package:mycontact/Provider/modelhud.dart';
import 'package:mycontact/Screens/users.dart/homepage.dart';
import 'package:mycontact/services/auth.dart';
import 'package:mycontact/widgets/logostack.dart';
import 'package:mycontact/Screens/signupScree.dart';
import 'package:mycontact/const.dart';
import 'package:mycontact/widgets/cusomtextfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin/AdminHome/adminhome.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isAdmin = false;
  String _email, _password;
  final _auth = Auth();
  final adminPassword = 'admin12345';
  bool keepMeLoggedin = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: kMainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<Modelhud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Container(
                      height: MediaQuery.of(context).size.height * .3,
                      child: Logostack()),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomTextField(
                    hint: 'Enter Email!',
                    icon: Icons.email,
                    onClick: (value) {
                      _email = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                            checkColor: kTextboxColor,
                            activeColor: kMainColor,
                            value: keepMeLoggedin,
                            onChanged: (value) {
                              setState(() {
                                keepMeLoggedin = value;
                              });
                            }),
                      ),
                      Text(
                        "Remember Me",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                      padding: EdgeInsets.all(1),
                      child: CustomTextField(
                        onClick: (value) {
                          _password = value;
                        },
                        hint: 'Enter Password!',
                        icon: Icons.lock,
                      )),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 140),
                  child: Builder(
                    builder: (context) => RaisedButton(
                      padding: EdgeInsets.all(1),
                      onPressed: () async {
                        if (keepMeLoggedin == true) {
                          keepUserLoggedIn();
                        }
                        _validate(context);
                      },
                      color: Colors.black,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.orange, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Padding(
                  padding: const EdgeInsets.all(100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Signup.id);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<AdminMode>(context, listen: false)
                                .changeIsAdmin(true);
                          },
                          child: Text(
                            'i\'m admin',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<AdminMode>(context).isAdmin
                                    ? kMainColor
                                    : Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(false);
                        },
                        child: Text(
                          'i\'m user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? Colors.white
                                  : kMainColor),
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<Modelhud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelhud.changeisLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          modelhud.changeisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong"),
          ));
        }
      } else {
        try {
          await _auth.signIn(_email.trim(), _password.trim());
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeisLoading(false);
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kkeepmeLoggerIn, keepMeLoggedin);
  }
}
