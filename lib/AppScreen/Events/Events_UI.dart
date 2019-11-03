import 'package:flutter/material.dart';
import '../../Service/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Constant/Constant_color.dart';
import '../../Constant/constant.dart';
import 'package:toast/toast.dart';

class Events_UI extends StatefulWidget {
  @override
  _Events_UIState createState() => _Events_UIState();
}

class _Events_UIState extends State<Events_UI> {
  var Data;
  var EventDate;
  bool isvisable = true;

  void FatchData() async {
    NetworkHelper nt =
        NetworkHelper(url: 'http://someti.scanitltd.com/api/office/event');
    try {
      print("request sent");
      var data = await nt.getData();
      print(data.toString() + "printed");

      setState(() {
        try {
          Data = data['data'][0]['event_title'];
          EventDate = data['data'][0]['event_date'];
          isvisable = false;
        } catch (e) {
          print(e.toString());
          Toast.show(e.toString(), context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      });
    } catch (e) {
      print(e.toString());
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FatchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyBackGroundColor,
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Visibility(
            visible: !isvisable,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Event Title : $Data ",
                      style: KFoodItemCardTitle.copyWith(
                          color: Colors.green, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Event Date : $EventDate ",
                      style: KFoodItemCardTitle.copyWith(
                          color: Colors.green, fontSize: 20),
                    ),
                  ],
                ),
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
      )),
    );
  }
}
