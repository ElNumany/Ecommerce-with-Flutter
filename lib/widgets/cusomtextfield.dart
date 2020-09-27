import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;

  String _error(String str) {
    switch (hint) {
      case 'Enter Name!':
        return 'Name is empty!';
      case 'Enter Email!':
        return 'Email is empty!';
      case 'Enter Password!':
        return 'Password is empty!';
    }
    return '';
  }

  CustomTextField(
      {
      //   @required this.onClick,
      @required this.hint,
      @required this.icon,
      @required this.onClick});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return _error(hint);
          }
        },
        onSaved: onClick,
        obscureText: hint == 'Enter Password!' ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: kMainColor,
            size: 20,
          ),
          filled: true,
          fillColor: kTextboxColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ));
  }
}
