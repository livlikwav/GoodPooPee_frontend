import 'package:flutter/material.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('배변훈련 리포트')),
      drawer: DrawerMenu(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: Center(
        child: Text('와우'),
      ),
    );
  }
}
