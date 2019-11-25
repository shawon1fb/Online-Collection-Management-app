import 'package:flutter/material.dart';
import '../../Constant/constant.dart';
import '../../Constant/Constant_color.dart';
import 'package:toast/toast.dart';
import '../../Service/networking.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class personal_file_ui extends StatefulWidget {
  @override
  _personal_file_uiState createState() => _personal_file_uiState();
}

class _personal_file_uiState extends State<personal_file_ui> {
  final storage = new FlutterSecureStorage();
  bool isvisable = true;
  var member_name;
  var member_Id;

  void FatchData() async {
    String member_id = await storage.read(key: 'member_id');
    String UserToken = await storage.read(key: 'UserToken');
    print("==============personal file============");
    print(member_id);
    print(UserToken);
    String URL =
        'http://someti.scanitltd.com/api/member/info/$member_id/$UserToken';

    print("URL : $URL");

    NetworkHelper nt = NetworkHelper(url: URL);
    try {
      print("request sent");
      var data = await nt.getData();
      print(data.toString() + "\n===========>> printed");

      setState(() {
        try {
          member_name = data['data'][0]['company_name'];
          member_Id = data['data'][0]['member_mobile'];
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
        title: Text('Personal File'),
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
                      "Company Name : $member_name ",
                      style: KFoodItemCardTitle.copyWith(
                          color: Colors.green, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Member Mobile : $member_Id ",
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
