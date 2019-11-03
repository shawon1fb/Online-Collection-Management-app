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

class Login_UI extends StatefulWidget {
  @override
  _Login_UIState createState() => _Login_UIState();
}

class _Login_UIState extends State<Login_UI> {
  final FocusNode _EmailFocus = FocusNode();
  final FocusNode _PasswordFocus = FocusNode();
  static final TextEditingController _firstNameController =
      new TextEditingController();
  static final TextEditingController _lastNameController =
      new TextEditingController();

  final EmailKey = GlobalKey<FormState>();
  final PasswordKey = GlobalKey<FormState>();
  String _email, _password;

  void _submit() async {
    if (EmailKey.currentState.validate()) {
      EmailKey.currentState.save();
      if (_email == 'abc@gmail.com' && _password == '1234') {
        var temp = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoard(
                    /*  latitude: p.latitude,
                              longitude: p.longitude,*/ /**/
                    )));
        if (temp == null) {
          exit(0);
        }
      } else {
        Toast.show("Username or Password Incorrect.", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
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
              Container(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: EnsureVisibleWhenFocused(
                                  child: new NormalTextField(
                                    focusNode: _EmailFocus,
                                    onFieldSubmitted: (term) {
                                      _EmailFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_PasswordFocus);
                                    },
                                    hint: 'Username',
                                    inputType: TextInputType.emailAddress,
                                    validator: (input) => !input.contains('@')
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: EnsureVisibleWhenFocused(
                                  child: new PasswordTextField(
                                    focusNode: _PasswordFocus,
                                    hint: 'Password',
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
                        text: "SIGN IN",
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
                            child: Text(
                              "SIGN UP",
                              style: KRedFlatButtonStyle,
                            ),
                          ),
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
    );
  }
}
