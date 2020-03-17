import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../Controllers/LoginController.dart';
import '../Widgets/EnsureVisibleWhenFocused.dart';
import '../../Utilities/Utilities.dart';

///Color palette for the 2 different login screens
///
const Color _backgroundDark = const Color(0xff122d31);
const Color _textDark = const Color(0x90ffffff);
const Color _textLight = const Color(0x38000000);
const Color _fieldDark = const Color(0xA0ffffff);
const Color _fieldLight = const Color(0x58000000);
const Color _logoLine3Red = const Color(0xffCE0E2D);

class LoginScreen extends StatefulWidget {
  LoginScreen({this.firstTime = true});

  final bool firstTime;
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

//TODO https://proandroiddev.com/how-to-dynamically-change-the-theme-in-flutter-698bd022d0f0 set a login theme with dark brightness
class LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  FocusNode usernameNode = new FocusNode();
  FocusNode passwordNode = new FocusNode();
  bool rememberMe = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }


  void remember(bool value) {
    rememberMe = value ?? false;
    setState(() {
      rememberMe = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginController loginController = LoginController();
    double logoPadding = Utils.screenRealEstate(context, hasNavBar: false, hasAppBar: true) / 5;
    return Builder(
      builder: (context) => ScopedModel<LoginController>(
        model: loginController,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            backgroundColor: widget.firstTime ? _backgroundDark : Theme.of(context).backgroundColor,
            key: _scaffoldKey,
            body: ListView(
              children: <Widget>[
                /*Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                  Text(
                    packageInfo != null ? packageInfo.version.toString() : "",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 9.0, color: widget.firstTime ? _textDark : _textLight),
                  )
                ]),
                DashbossLogo(
                  width: widget.firstTime ? 300 : 185,
                  textColor: widget.firstTime ? Colors.white : _backgroundDark,
                ),
                Container(
                  height: logoPadding / 1.5,
                ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      EnsureVisibleWhenFocused(
                        focusNode: usernameNode,
                        child: TextFormField(
                          autocorrect: false,
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: widget.firstTime ? _fieldDark : _fieldLight),
                          focusNode: usernameNode,
                          onFieldSubmitted: (value) {
                            usernameNode.unfocus();
                            FocusScope.of(context).requestFocus(passwordNode);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: widget.firstTime ? _textDark : _textLight,
                            ),
                            labelText: 'username',
                            labelStyle: TextStyle(color: widget.firstTime ? _textDark : _textLight),
                          ),
                        ),
                      ),
                      ScopedModelDescendant<LoginController>(builder: (context, child, model) {
                        return EnsureVisibleWhenFocused(
                          focusNode: passwordNode,
                          child: TextFormField(
                            autocorrect: false,
                            style: TextStyle(color: widget.firstTime ? _fieldDark : _fieldLight),
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: !model.showPassword,
                            focusNode: passwordNode,
                            onFieldSubmitted: (value) async {
                              await loginMethod(context, loginController);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: widget.firstTime ? _textDark : _textLight,
                                ),
                                labelText: 'password',
                                suffix: IconButton(
                                  icon: model.showPassword
                                      ? Icon(Icons.remove_red_eye,
                                          color: widget.firstTime ? _fieldDark : _fieldLight)
                                      : Icon(Icons.remove_red_eye,
                                          color: widget.firstTime ? _fieldDark : _fieldLight),
                                  onPressed: () {
                                    model.updateShowPassword();
                                  },
                                ),
                                labelStyle: TextStyle(color: widget.firstTime ? _textDark : _textLight)),
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(),
                            Container(
                              width: 20,
                            ),
                            loginButton(
                                        context, 'LOGIN!!!',
                                        () async {
                                      await loginMethod(context, loginController);
                                    }, onLongPress: () {
                                      
                                    })
                            /* Padding(
                              padding: const EdgeInsets.only(right: 14.0, top: 8.0),
                              child: GestureDetector(
                                onLongPress: () {
                                  Navigator.of(context).pushNamed(RouteNames.preferenceScreen);
                                },
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(width: 2.0, color: Theme.of(context).primaryColor)),
                                  child: Text(
                                    FlutterI18n.translate(context, StringsKeys.str_login),
                                    style: TextStyle(color: Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () {
                                    loginMethod(context);
                                  },
                                ),
                              ),
                            )*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future loginMethod(BuildContext context, LoginController model) async {
    FocusScope.of(context).unfocus();
    String _password = passwordController.text;
    setState(() {
      passwordController.text = "";
    });
    await model.loginRequest(usernameController.text, _password, rememberMe);
    if (model.isSuccess) {
      print('SUCCESS!!');
    } else {
      showSnackBar();
    }
  }

  void showSnackBar() {
    final snackBarContent = SnackBar(
      content: Text(
        'YOU FAILED!!!'
      ),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBarContent);
  }
}

Widget loginButton(BuildContext context, String text, Function callback, {Function onLongPress}) {
  return GestureDetector(
    onLongPress: onLongPress,
    child: RaisedButton(
      elevation: 0,
      hoverElevation: 2,
      color: _logoLine3Red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        /*side: BorderSide(width: 2.0, color: Theme.of(context).primaryColor)*/
      ),
      onPressed: () {
        callback();
      },
      child: Text(
        text,
      ),
      textColor: Colors.white,
    ),
  );
}

Widget goBackButton(BuildContext context, String text) {
  return GestureDetector(
    child: RaisedButton(
      elevation: 0,
      hoverElevation: 2,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), side: BorderSide(width: 2.0, color: _backgroundDark)),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        text,
      ),
      textColor: _backgroundDark,
    ),
  );
}
