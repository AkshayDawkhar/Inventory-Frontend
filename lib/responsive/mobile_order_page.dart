import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class MobileOrderPage extends StatefulWidget {
  const MobileOrderPage({Key? key}) : super(key: key);

  @override
  State<MobileOrderPage> createState() => _MobileOrderPageState();
}

class _MobileOrderPageState extends State<MobileOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('ORDERS'),
      drawer: myDrawer(context, 2),
      body: Text('Order'),

    ) ;
  }
}
