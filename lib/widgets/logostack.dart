import 'package:flutter/material.dart';

class Logostack extends StatelessWidget {
  const Logostack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image(
            image: AssetImage(
          'images/icons/mainicon.png',
        )),
        Positioned(
          top: 150,
          child: Text(
            'الحفيد',
            style: TextStyle(
                fontFamily: 'Rakkas', fontSize: 50.0, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
