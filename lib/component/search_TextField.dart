import 'package:flutter/material.dart';
import '../Constant/Constant_color.dart';

class Search_TextFeild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          prefixIcon: Icon(Icons.search,),
          //icon: Icon(Icons.search),
          hintText: "Search ID",

          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[400]),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
