import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "login",
      home: _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _focusUserNameNode = FocusNode();
  FocusNode _focusPasswordNode = FocusNode();
  Widget _showLogin = Image.asset(
    "images/banana.png",
    width: 90.0,
    height: 90.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    _focusUserNameNode.addListener(() {
      setState(() {
        if (_focusUserNameNode.hasFocus) {
          _showLogin = Container();
        } else {
          _showLogin = Image.asset(
            "images/banana.png",
            width: 90.0,
            height: 90.0,
          );
        }
      });
    });
    _focusPasswordNode.addListener(() {
      setState(() {
        if (_focusPasswordNode.hasFocus) {
          _showLogin = Container();
        } else {
          _showLogin = Image.asset(
            "images/banana.png",
            width: 90.0,
            height: 90.0,
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FlatButton(
            onPressed: () {
              _focusPasswordNode.unfocus();
              _focusUserNameNode.unfocus();
            },
            child: Stack(
              alignment: FractionalOffset(0.5, 0.2),
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          icon: Icon(Icons.person),
                          labelText: "用户名",
                          helperText: "输入你的用户名",
                        ),
                        autofocus: false,
                        controller: _usernameController,
                        focusNode: _focusUserNameNode,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          icon: Icon(Icons.lock),
                          labelText: "密码",
                          helperText: "输入你的密码",
                        ),
                        autofocus: false,
                        controller: _passwordController,
                        focusNode: _focusPasswordNode,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: RaisedButton(
                          onPressed: () {
                            _login().then((result) {
                              if (result) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return IndexActivity();
                                }));
                              }else{
                                Fluttertoast.showToast(
                                    msg: "登录失败",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            });
                          },
                          child: Text("登录"),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                )),
                _showLogin,
              ],
            )));
  }

  Future<bool> _login() async {
    _focusPasswordNode.unfocus();
    _focusUserNameNode.unfocus();
    if (_usernameController.text == null ||
        _passwordController.text == null ||
        _usernameController.text == "" ||
        _passwordController.text == "") {
      return Future.value(false);
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String word = sharedPreferences.getString("login");
    if (word == null) {
      await sharedPreferences.setString(
          "login", "${_usernameController.text}&${_passwordController.text}");
      return Future.value(true);
    } else if (word ==
        "${_usernameController.text}&${_passwordController.text}") {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
