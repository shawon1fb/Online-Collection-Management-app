import 'package:flutter/material.dart';
import '../../Service/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Constant/Constant_color.dart';
import '../../Constant/constant.dart';
import 'package:toast/toast.dart';

class Munafa_UI extends StatefulWidget {
  @override
  _Munafa_UIState createState() => _Munafa_UIState();
}

class _Munafa_UIState extends State<Munafa_UI> {
  var Data;

  bool isvisable = true;

  void FatchData() async {

    try {
      NetworkHelper nt =
      NetworkHelper(url: 'http://someti.scanitltd.com/api/totalincome');
      print("request sent");
      var data = await nt.getData();
      print(data.toString() + "printed");

      setState(() {
        try {
          Data = data['data'][0]['income'];

          isvisable = false;
        } catch (e) {
          print(e.toString());
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
        title: Text('Munafa'),
      ),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Visibility(
            visible: !isvisable,
            child: Center(
              child: Text(
                "Total Income : $Data BDT",
                style: KFoodItemCardTitle.copyWith(
                    color: Colors.green, fontSize: 20),
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
