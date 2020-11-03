import 'package:flutter/material.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: AppBar(title: null),
        drawer: DrawerMenu(),
        body: Center(
          child: Text('WOW'),
        ),
      ),
    );
  }
}
