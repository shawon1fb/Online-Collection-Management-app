import 'package:flutter/material.dart';
import '../../Constant/Constant_color.dart';
import '../../Constant/constant.dart';
import '../../component/Normal_TextField.dart';
import '../../component/password_input_textField.dart';
import 'package:shomity_app/AppScreen/Dashbord/DashBoard.dart';
import 'package:toast/toast.dart';
import '../../Helper/ensure_visible.dart';
import '../../component/LoginButton.dart';
import 'dart:io';
import '../../Logic/API/SIgnUP_API.dart';
import 'Login_UI.dart';

class Sign_up_UI extends StatefulWidget {
  @override
  _Sign_up_UIState createState() => _Sign_up_UIState();
}

class _Sign_up_UIState extends State<Sign_up_UI> {
  final FocusNode _EmailFocus = FocusNode();
  final FocusNode _PasswordFocus = FocusNode();
  static final TextEditingController _firstNameController =
      new TextEditingController();
  static final TextEditingController _lastNameController =
      new TextEditingController();

  final EmailKey = GlobalKey<FormState>();
  final PasswordKey = GlobalKey<FormState>();
  String _email, _password;

  bool visiable = false;

  Future<bool> _onWillPop(message) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Report !!',
              style: TextStyle(color: Colors.red),
            ),
            content: new Text('$message'),
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

  void ChangeVisiable(bool b) {
    setState(() {
      visiable = b;
    });
  }

  void _submit() async {
    ChangeVisiable(true);

    if (EmailKey.currentState.validate()) {
      EmailKey.currentState.save();
      if (_email != null && _password != null) {
        SignUP_API SignUP = new SignUP_API();
        var responce = await SignUP.SignUP_Request(_email, _password);
        print('=============================');
        print("test   Sign UP  = = = = = = = =");
        print(responce);
        if (responce != null) {
          if (responce['access_token'] != null) {
            ChangeVisiable(false);
            var temp = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login_UI(),
              ),
            );
            if (temp == null) {
              exit(0);
            }
          } else {
            ChangeVisiable(false);
            bool b = await _onWillPop(responce['message'].toString());
            Toast.show(responce['message']['member_id'][0].toString(), context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        }
      } else {
        ChangeVisiable(false);
        bool b = await _onWillPop("Username or Password Incorrect.");
        Toast.show("Username or Password Incorrect.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      ChangeVisiable(false);
    }
  }

  Future<Null> _focusNodeListener() async {
    if (_PasswordFocus.hasFocus) {
      print('TextField got the focus');
    } else {
      print('TextField lost the focus');
    }

    if (_EmailFocus.hasFocus) {
      print('Email got the focus');
    } else {
      print('Email lost the focus');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _PasswordFocus.addListener(_focusNodeListener);
    _EmailFocus.addListener(_focusNodeListener);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _PasswordFocus.removeListener(_focusNodeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var Sk_hight = MediaQuery.of(context).size.height;
    var Sk_width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: login_UI_BacgroundColor,
      body: SafeArea(
        child: Container(
          padding: GolobalPadding,
          child: Stack(
            children: <Widget>[
              Container(
                height: Sk_hight * 0.5,
                width: Sk_width,
                child: Center(
                  child: Image.asset('images/logo.png'),
                ),
              ),
              Visibility(
                visible: visiable,
                child: Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !visiable,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: Sk_hight * 0.5,
                          width: Sk_width,
                        ),
                        Form(
                            key: EmailKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: EnsureVisibleWhenFocused(
                                    child: new NormalTextField(
                                      focusNode: _EmailFocus,
                                      onFieldSubmitted: (term) {
                                        _EmailFocus.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(_PasswordFocus);
                                      },
                                      hint: 'member_id',
                                      inputType: TextInputType.emailAddress,
                                      validator: (input) => input.length < 1
                                          ? 'Not a valid Email'
                                          : null,
                                      OnSaved: (input) => _email = input,
                                    ),
                                    focusNode: _EmailFocus,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: EnsureVisibleWhenFocused(
                                    child: new PasswordTextField(
                                      focusNode: _PasswordFocus,
                                      hint: 'member_name',
                                      validator: (input) => input.length < 4
                                          ? 'You need at least 4 characters'
                                          : null,
                                      OnSaved: (input) => _password = input,
                                    ),
                                    focusNode: _PasswordFocus,
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        LoginButton(
                          text: "SIGN UP",
                          onPress: () {
                            _submit();

                            print('log in pressed');
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          child: Center(
                            child: InkWell(
                              onTap: () => Navigator.pop(context, false),
                              child: Text(
                                "SIGN IN",
                                style: KRedFlatButtonStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
