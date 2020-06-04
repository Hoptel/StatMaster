import 'package:StatMaster/Controllers/EmployeeController.dart';
import 'package:StatMaster/Controllers/MainController.dart';
import 'package:StatMaster/View/Screens/LoginScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'UserListItem.dart';
import 'package:flutter/material.dart';
import '../../Utilities/Preference.dart';
import '../../Utilities/Utilities.dart';
import 'package:scoped_model/scoped_model.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EmployeeController empcontroller = MainController.getInstance().employeeController;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context, empcontroller),
          _createHotelSelectionButton(context, empcontroller),
          _createDrawerItem(
            icon: FontAwesomeIcons.thLarge,
            text: Text(
              "Home",
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({IconData icon, Widget text, Function onTap}) {
    return ListTile(
      title: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: text,
              )
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader(BuildContext context, EmployeeController model) {
    return ScopedModel<EmployeeController>(
      model: model,
      child: Container(
        height: 170 + Utils.statusBarHeight(context),
        child: DrawerHeader(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(color: Color(0xff707070)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ScopedModelDescendant<EmployeeController>(builder: (context, child, model) {
                return InkWell(
                  borderRadius: BorderRadius.circular(300),
                  onTap: () {
                    getUserSheet(context, model);
                  },
                  child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: model.employeeImagesLoaded ? BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                              offset: Offset(
                                1.0,
                                3.0,
                              ),
                            )
                          ],
                          image: DecorationImage(image: model.currentImage) ,
                          shape: BoxShape.circle,)
                          : BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                              offset: Offset(
                                1.0,
                                3.0,
                              ),
                            )
                          ],
                          shape: BoxShape.circle,)
                          ),
                );
              }),
              Container(
                height: 9,
              ),
              ScopedModelDescendant<EmployeeController>(builder: (context, child, model) {
                return Text(
                  model.employeeDataLoaded
                      ? model.currentEmployee.fullname
                      : "",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                );
              }),
              ScopedModelDescendant<EmployeeController>(builder: (context, child, model) {
                return Text(model.employeeDataLoaded ? model.currentEmployee.email : "",
                    style: TextStyle(fontWeight: FontWeight.w100, color: Colors.white, fontSize: 12.0));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createHotelSelectionButton(BuildContext context, EmployeeController model) {
    return ScopedModel<EmployeeController>(
      model: model,
      child: Container(
        height: 36.0,
        color: Theme.of(context).appBarTheme.color,
        child: InkWell(
          onTap: () {
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ScopedModelDescendant<EmployeeController>(builder: (context, child, model) {
                  return Text(
                    model.employeeDataLoaded ? model.employeeHotels.first.hotelname : "",
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogOut(BuildContext context) {
    Preference.setBool("remember_me", false);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()) , (Route<dynamic> route) => false);
  }

  void getUserSheet(context, EmployeeController model) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext context) {
          return Container(
            height: 312,
            child: ScopedModel<EmployeeController>(
              model: MainController.getInstance().employeeController,
              child: ScopedModelDescendant<EmployeeController>(builder: (context, child, model) {
                return ListView(
                  children: getUserWidgetList(model, context),
                );
              }),
            ),
          );
        });
  }

  List<Widget> getUserWidgetList(EmployeeController model, BuildContext context) {
    List<Widget> widgetList = [Container(height: 15)];
    if (model.employeeDataLoaded) {
      model.employeeData.forEach((k, v) {
        widgetList.add(UserListItem(
          k,
          image: model.employeeImages[k],
          disableLogin: v == model.currentEmployee,
          disableLogout: v == model.currentEmployee,
        ));
      });
      widgetList.add(UserListItem.differentAccount(context));
      return widgetList;
    } else
      return <Widget>[];
  }

  void _logoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 5,
            title: Center(
                child: Text(
              "Attention",
            )),
            content: Text("Logout?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.color,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _handleLogOut(context);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.color,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
