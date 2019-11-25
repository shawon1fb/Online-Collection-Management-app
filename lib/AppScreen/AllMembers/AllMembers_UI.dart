import 'package:flutter/material.dart';
import '../../Constant/Constant_color.dart';
import 'package:shomity_app/Constant/constant.dart';
import '../../Service/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'MemberDetails.dart';

class AllMembers_UI extends StatefulWidget {
  @override
  _AllMembers_UIState createState() => _AllMembers_UIState();
}

class _AllMembers_UIState extends State<AllMembers_UI> {
  bool isvisable = true;
  List<MemberDetails> MemberList = new List();
  List<MemberDetails> GEtMemberList = new List();

  ScrollController _scrollController = new ScrollController();

  void FatchData() async {
    NetworkHelper nt =
        NetworkHelper(url: 'http://someti.scanitltd.com/api/member/index');
    try {
      print("request sent");
      var data = await nt.getData();
      print(data.toString() + "printed");

      List<dynamic> lst = data['data']['data'];

      int cnt = 0;
      setState(() {
        try {
          print(lst.length);
          print(lst[19]['member_name']);
          print("===============");
          for (var i in lst) {
            print("i = " + cnt.toString());
            cnt++;
            print(i['member_name'].toString());
            MemberList.add(
              new MemberDetails(
                Member_Name: i['member_name'],
                Member_ID: i['member_id'],
              ),
            );
          }

          // fatch_five();
          isvisable = false;
        } catch (e) {
          print("============= All memeber execption ++++++++++++");
          print(e.toString());
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  int flag = 0;

  /*void fatch_five() {
    for (int i = 0; i < 10; i++) {
      setState(() {
        MemberList.add(GEtMemberList[flag + i]);
        flag++;
      });
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FatchData();
    /* _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fatch_five();
        print("ok");
      }
    });*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyBackGroundColor,
      appBar: AppBar(
        title: Text('All Members'),
      ),
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Visibility(
            visible: !isvisable,
            child: Container(
              child: ListView.builder(
                  //controller: _scrollController,
                  itemCount: MemberList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Name: ${MemberList[index].Member_Name}',
                              style: KUserName.copyWith(color: Colors.green),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Member ID: ${MemberList[index].Member_ID}',
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
                  }),
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
