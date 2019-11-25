import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shomity_app/Constant/Constant_color.dart';
import 'package:shomity_app/Constant/constant.dart';
import 'package:shomity_app/Logic/API/Chada_API.dart';
import 'package:toast/toast.dart';
import 'dart:io';

import 'ChadaView.dart';
import 'Chada_data_model.dart';

class Chada_UI extends StatefulWidget {
  @override
  _Chada_UIState createState() => _Chada_UIState();
}

class _Chada_UIState extends State<Chada_UI> {
  bool isvisable = false;
  final storage = new FlutterSecureStorage();
  Chada_API chada_api = new Chada_API();
  var totalcollect;
  String from_date = '';
  String to_date = '';
  List<ChadaView> Chada_List = new List();

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        /* from_date =
            "${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}";*/
      });
  }

  void facth_data() async {
    setState(() {
      isvisable = true;
    });

    String member_id = await storage.read(key: 'member_id');

    try {
      var responce =
          await chada_api.Chada_Request(member_id, from_date, to_date);
      print(responce['collectdates'][0]['collect']);

      setState(() {
        if (responce != null) {
          if (responce['collectdates'][0]['collect'] != null) {
            totalcollect = responce['collectdates'][0]['collect'];
          } else {
            totalcollect = '00';
          }

          print("==============chada list length =================");
          print(Chada_List.length);

          isvisable = false;
        } else {
          Toast.show("Request Failed.", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      });

      for (var i in responce['dates']) {
        print(i['member_id']);
        Chada_List.add(new ChadaView(
          member_date: i['member_date'],
          member_chada_amount: i['member_chada_amount'],
        ));
      }
    } catch (e) {
      print('=====================Chada Execption ++++++++++++++++++');
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // facth_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bodyBackGroundColor,
      appBar: AppBar(
        title: Text('Personal File'),
      ),
      body: SafeArea(
          child: Container(
        padding: GolobalPadding,
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: !isvisable,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: FlatButton(
                              onPressed: () async {
                                await _selectDate(context);
                                setState(() {
                                  from_date =
                                      "${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}";
                                });
                              },
                              child: Container(
                                width: 100.0,
                                child: Center(
                                  child: Text(
                                    'From date',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "$from_date ",
                                style: KFoodItemCardTitle.copyWith(
                                    color: Colors.green, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: FlatButton(
                              onPressed: () async {
                                await _selectDate(context);
                                setState(() {
                                  to_date =
                                      "${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}";
                                });
                              },
                              child: Container(
                                width: 100.0,
                                child: Center(
                                  child: Text(
                                    'To date',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "$to_date ",
                                style: KFoodItemCardTitle.copyWith(
                                    color: Colors.green, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: FlatButton(
                          onPressed: () {
                            facth_data();
                          },
                          child: Container(
                            width: width,
                            child: Center(
                              child: Text(
                                'Chada',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                          color: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Total collection : $totalcollect ",
                        style: KFoodItemCardTitle.copyWith(
                            color: Colors.green, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: hight * 0.4,
                        width: width,
                        child: ListView(
                          children: <Widget>[
                                Container(),
                                Center(
                                  child: Text(
                                    'Chada collection Details',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 2.0,
                                  color: Colors.green,
                                ),
                              ] +
                              Chada_List,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isvisable,
              child: Center(
                child: SpinKitDoubleBounce(
                  color: Colors.green,
                  size: 100.0,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
