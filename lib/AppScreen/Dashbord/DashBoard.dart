import 'package:flutter/material.dart';
import '../../Constant/Constant_color.dart';
import '../../Constant/constant.dart';
import 'DashBordPageOne.dart';
import 'DashBordPageTwo.dart';
import '../../component/search_TextField.dart';
import 'package:dots_indicator/dots_indicator.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentIndexPage = 0;

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void setCurrentPage(int index) {
    setState(() {
      currentIndexPage = index;
      print(currentIndexPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    var Sk_Hight = MediaQuery.of(context).size.height;
    var Sk_Width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        drawer: Text(
          " No Drawer ",
          style: TextStyle(color: Colors.white),
        ),
        appBar: AppBar(
          title: Text("ShomityAPP"),
          backgroundColor: AppBarColor,
        ),
        body: SafeArea(
          child: Container(
            padding: GolobalPadding,
            decoration: BoxDecoration(
              color: bodyBackGroundColor,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: Sk_Hight,
                  width: Sk_Width,
                  child: Image.asset(
                    'images/logo.png',
                  ),
                ),
                Container(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Search_TextFeild(),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            child: Container(
                              child: PageView(
                                onPageChanged: (index) {
                                  setCurrentPage(index);
                                },
                                children: <Widget>[
                                  DashBordPageOne(),
                                  DashBordPageTwo(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 20.0,
                                  ),
                                  child: DotsIndicator(
                                    dotsCount: 2,
                                    position: currentIndexPage,
                                    decorator: DotsDecorator(
                                      color: Colors.grey,
                                      activeColor: Colors.green[500],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
