import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class DesktopAccountPage extends StatefulWidget {
  const DesktopAccountPage({Key? key}) : super(key: key);

  @override
  State<DesktopAccountPage> createState() => _DesktopAccountPageState();
}

class _DesktopAccountPageState extends State<DesktopAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('ACCOUNT'),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 3)),
          Expanded(flex: 6, child: Text('account'))
        ],
      ),
    );
  }
}
