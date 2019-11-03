import 'package:flutter/material.dart';
import '../../component/DashBord_Card.dart';
import '../../Service/networking.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../Munafa/Munafa_UI.dart';
import '../Events/Events_UI.dart';
import '../AllMembers/AllMembers_UI.dart';

class DashBordPageOne extends StatefulWidget {
  @override
  _DashBordPageOneState createState() => _DashBordPageOneState();
}

class _DashBordPageOneState extends State<DashBordPageOne> {
  @override
  Widget build(BuildContext context) {
    //var Sk_Hight = MediaQuery.of(context).size.height;
    //var Sk_Width = MediaQuery.of(context).size.width;
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
                      text: 'Munafa',
                      function: () async {
                        try {
                          print("request sent");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Munafa_UI()));
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                    Dashbord_Card(
                      SVGPath: 'images/community.svg',
                      text: 'All Member',
                      function: () async {
                        try {
                          print("request sent");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllMembers_UI()));
                        } catch (e) {
                          print(e.toString());
                        }
                      },
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
                      SVGPath: 'images/schedule.svg',
                      text: 'Events',
                      function: () async {
                        try {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Events_UI(),
                            ),
                          );
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                    Dashbord_Card(
                      SVGPath: 'images/man.svg',
                      text: 'Personal File',
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
                      text: 'Guarantor',
                    ),
                    Dashbord_Card(
                      SVGPath: 'images/money.svg',
                      text: 'Notification',
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
