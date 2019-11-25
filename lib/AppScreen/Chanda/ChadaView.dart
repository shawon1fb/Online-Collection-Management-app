import 'package:flutter/material.dart';
import 'package:shomity_app/Constant/constant.dart';

class ChadaView extends StatefulWidget {
  ChadaView({this.member_date, this.member_chada_amount});

  final member_date;
  final member_chada_amount;

  @override
  _ChadaViewState createState() => _ChadaViewState();
}

class _ChadaViewState extends State<ChadaView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: <Widget>[
            Text(
              'Date : ${widget.member_date}',
              style: KUserName.copyWith(color: Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Chada Amount : ${widget.member_chada_amount}',
              style: KUserName.copyWith(color: Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
