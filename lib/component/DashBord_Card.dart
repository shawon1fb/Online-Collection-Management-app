import 'package:flutter/material.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashbord_Card extends StatefulWidget {
  Dashbord_Card({this.SVGPath, this.text,this.function});

  final SVGPath;
  final text;
  final Function function;

  @override
  _Dashbord_CardState createState() => _Dashbord_CardState();
}

class _Dashbord_CardState extends State<Dashbord_Card> {
  @override
  Widget build(BuildContext context) {
    var Sk_Hight = MediaQuery.of(context).size.height;
    var Sk_Width = MediaQuery.of(context).size.width;
    return Container(
      child: Container(
        padding: EdgeInsets.all(5),

        child: Container(
          padding: EdgeInsets.all(0.0),
          //height: Sk_Width * 0.3,
          width: Sk_Width * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            border: Border.all(
              color: Colors.green,
              width: 3.0,
            ),
          ),
          child: FlatButton(
            padding: EdgeInsets.all(0.0),
            onPressed: (){
              print("Tap work");
              widget.function();
            },
            child: Column(
              children: <Widget>[
                Container(
                  child: new SvgPicture.asset(
                    '${widget.SVGPath}',
                    height: Sk_Width * 0.3 * 0.7,
                    width: Sk_Width * 0.3 * 0.7,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.text}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
