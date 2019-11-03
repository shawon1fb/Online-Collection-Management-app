import 'package:flutter/material.dart';
import '../Constant/constant.dart';

class LoginButton extends StatelessWidget {
  LoginButton({@required this.text, this.onPress});

  final text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RaisedButton(

        padding: EdgeInsets.all(15.0),
        color: Color(0xff27AE61),
        disabledColor: Color(0xff000000),
        onPressed: onPress,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              '$text',
              style: KRedFlatButtonStyle,
            )),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Color(0xff27AE61))),
      ),
    );
  }
}