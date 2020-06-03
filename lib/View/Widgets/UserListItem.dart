import 'package:StatMaster/View/Screens/LoginScreen.dart';
import 'package:StatMaster/View/Screens/WidgetsScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Controllers/MainController.dart';
import 'ImageDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../Utilities/Preference.dart';

///This widget is a single list item containing a user avatar and username, clicking on it triggers the login function,
///and clicking the X to the right triggers a function to delete the user from the login list.
class UserListItem extends StatelessWidget {
  UserListItem(this.username,
      {this.image, this.icon, this.disableLogin = false, this.disableLogout = false, this.goToLogin = false});

  ///Whether or not to disable the X for deleting the user.
  final bool disableLogout;

  ///Whether or not to disable the click effect for the user.
  final bool disableLogin;

  ///An icon to be placed in the center of the avatar circle (mutually exclusive with [image]).
  final IconData icon;

  ///The avatar image (mutually exclusive with [icon]).
  final FileImage image;

  ///The username (user Code for Orest) to be used for the name and to be sent for login.
  final String username;

  ///Whether to redirect the user to a login screen or log them in automatically.
  final bool goToLogin;

  ///a prefab for the "add another account" item.
  factory UserListItem.differentAccount(BuildContext context) {
    return UserListItem(
      "Use a different account",
      disableLogout: true,
      icon: FontAwesomeIcons.userPlus,
      goToLogin: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert((image == null) || (icon == null));
    return InkWell(
      onTap: goToLogin
          ? () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
            }
          : disableLogin
              ? () {}
              : () {
                  _changeUserDialog(context, username);
                },
      child: Container(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 45.0,
                height: 45.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff9a9a9a),
                    image: image != null
                        ? new DecorationImage(
                            fit: BoxFit.cover,
                            image: image,
                          )
                        : null),
                child: icon != null
                    ? Icon(
                        icon,
                        size: 18,
                      )
                    : null,
              ),
              Text(username),
              Visibility(
                visible: !disableLogout,
                child: InkWell(
                    onTap: () async {
                      await Preference.removeLoginAuth(username);
                      await MainController.getInstance().employeeController.resetData();
                    },
                    child: Icon(
                      FontAwesomeIcons.times,
                      color: Color(0xFF6B6B6B),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _changeUserDialog(BuildContext context, String code) {
  showDialog(
      context: context,
      builder: (context) {
        return ImageDialog(
          title: code,
          description: "You're about to change users",
          confirmText: "Confirm",
          cancelText: "Cancel",
          image: MainController.getInstance().employeeController.employeeImages[code],
          buttonClicked: () async {
            await MainController.getInstance().loginController.changeUser(code);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => WidgetsScreen()),
              (Route<dynamic> route) => false,
            );
          },
        );
      });
}
