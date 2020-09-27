import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mycontact/Provider/modelhud.dart';
import 'package:mycontact/Screens/loginScreen.dart';
import 'package:mycontact/Screens/users.dart/homepage.dart';
import 'package:mycontact/services/auth.dart';
import 'package:mycontact/widgets/cusomtextfield.dart';
import '../const.dart';
import '../widgets/logostack.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'signup';
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * .01;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Logostack(),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  // onClick: () {},
                  hint: 'Enter Name!',
                  icon: Icons.person_outline,
                ),
              ),
              SizedBox(
                height: height * 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  onClick: (value) {
                    _email = value;
                  },
                  hint: 'Enter Email!',
                  icon: Icons.email,
                ),
              ),
              SizedBox(
                height: height * 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                height: height,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: Builder(
                  builder: (context) => RaisedButton(
                    padding: EdgeInsets.all(1),
                    onPressed: () async {
                      final modelhud =
                          Provider.of<Modelhud>(context, listen: false);
                      modelhud.changeisLoading(true);
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final authResult = await _auth.signUp(
                              _email.trim(), _password.trim());
                          modelhud.changeisLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                        } catch (e) {
                          modelhud.changeisLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: kTextboxColor,
                              content: Text(e.message)));
                        }
                        modelhud.changeisLoading(false);

                        //do Something
                      }
                    },
                    color: Colors.black,
                    child: Text(
                      'Register',
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
                      'Do have an account ?',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
