import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class DesktopOrderPage extends StatefulWidget {
  const DesktopOrderPage({Key? key}) : super(key: key);

  @override
  State<DesktopOrderPage> createState() => _DesktopOrderPageState();
}

class _DesktopOrderPageState extends State<DesktopOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('ORDERS'),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 2)),
          Expanded(flex: 6, child: Text('orders'))
        ],
      ),
    );
  }
}
