import 'package:Mealie/home/homePageWidget.dart';
import 'package:Mealie/order/orderScreen.dart';
import 'package:Mealie/settings/settingsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            color: Theme.of(context).accentColor,
            child: Center(
              child: Text(
                "Bon Appetite!",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomePage.route);
            },
            enabled: true,
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.route);
            },
            enabled: true,
            leading: Icon(Icons.shopping_basket),
            title: Text(
              'Orders',
              style: TextStyle(fontSize: 20),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(SettingsScreen.route);
            },
            enabled: true,
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
          ListTile(
            onTap: () {
              _logout();
            },
            enabled: true,
            leading: Icon(Icons.power_settings_new),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
          Center(
              child: Text(
            "Mealie v1.0.0",
            style: Theme.of(context).textTheme.bodyText1,
          ))
        ],
      ),
    );
  }

  void _logout() {
    FirebaseAuth.instance.signOut();
  }
}
