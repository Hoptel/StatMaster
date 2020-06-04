import 'package:StatMaster/View/Screens/WidgetsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../Controllers/LoginController.dart';
import '../../theme.dart';
import '../Widgets/EnsureVisibleWhenFocused.dart';
import '../../Utilities/Preference.dart';
import '../../Utilities/Utilities.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

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

  @override
  Widget build(BuildContext context) {
    LoginController loginController = LoginController();
    double logoPadding = Utils.screenRealEstate(context, hasNavBar: false, hasAppBar: false) * 0.1;
    return Builder(
      builder: (context) => ScopedModel<LoginController>(
        model: loginController,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            key: _scaffoldKey,
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SvgPicture.asset('resources/image_assets/app_logo_foreground.svg',
                  width: Utils.screenWidth(context)-20.0,
                ),
                Container(
                  height: logoPadding / 1.5,
                ),
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
                          focusNode: usernameNode,
                          onFieldSubmitted: (value) {
                            usernameNode.unfocus();
                            FocusScope.of(context).requestFocus(passwordNode);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            labelText: 'username',
                          ),
                        ),
                      ),
                      ScopedModelDescendant<LoginController>(builder: (context, child, model) {
                        return EnsureVisibleWhenFocused(
                          focusNode: passwordNode,
                          child: TextFormField(
                            autocorrect: false,
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
                                ),
                                labelText: 'password',
                                suffix: InkWell(borderRadius: BorderRadius.circular(30),
                                  child: model.showPassword
                                      ? Icon(Icons.remove_red_eye,)
                                      : Icon(Icons.remove_red_eye,),
                                  onTap: () {
                                    model.updateShowPassword();
                                  },
                                ),),
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
                                    }, )
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
      print(await Preference.getSecureString('guid'));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => WidgetsScreen()), (route) => false);
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
      onPressed: () {
        callback();
      },
      child: Text(
        text, style: TextStyle(color: AppColors.secondaryLight),
      ),
      textColor: Colors.white,
    ),
  );
}
