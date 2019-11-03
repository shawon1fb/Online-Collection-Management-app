import 'package:flutter/material.dart';
import '../Constant/constant.dart';

class NormalTextField extends StatelessWidget {
  NormalTextField({
    this.hint,
    @required this.inputType,
    this.validator,
    this.OnSaved,
    this.key,
    this.focusNode,
    this.onFieldSubmitted,
  });

  final hint;
  final TextInputType inputType;

  final Function validator;
  final Function OnSaved;
  final Function onFieldSubmitted;

  final Key key;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted:onFieldSubmitted,
      focusNode: focusNode,
      autofocus: true,
      key: key,
      style: KInputTextStyle,
      validator: validator,
      onSaved: OnSaved,
      textInputAction: TextInputAction.done,
      keyboardType: inputType,
      decoration: InputDecoration(
        /*focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),*/
      /*  enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),*/
        hintText: '$hint',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}