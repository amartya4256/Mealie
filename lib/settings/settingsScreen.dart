import 'package:Mealie/drawer/drawerWidget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static final String route = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(),
    );
  }
}
