import 'package:flutter/material.dart';
import '../../component/search_TextField.dart';
import '../../component/DashBord_Card.dart';

class DashBordPageTwo extends StatefulWidget {
  @override
  _DashBordPageTwoState createState() => _DashBordPageTwoState();
}

class _DashBordPageTwoState extends State<DashBordPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Dashbord_Card(
                      SVGPath: 'images/money.svg',
                      text: 'Chada',
                    ),
                    Dashbord_Card(
                      SVGPath: 'images/money.svg',
                      text: 'Loan',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Dashbord_Card(
                      SVGPath: 'images/money.svg',
                      text: 'Reminder',
                    ),
                    Dashbord_Card(
                      SVGPath: 'images/money.svg',
                      text: 'Company',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Dashbord_Card(
                      SVGPath: 'images/money.svg',
                      text: 'Accounts',
                    ),
                    Dashbord_Card(
                      SVGPath: 'images/money.svg',
                      text: 'Fine',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
