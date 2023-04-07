import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class DesktopProductsPage extends StatefulWidget {
  const DesktopProductsPage({Key? key}) : super(key: key);

  @override
  State<DesktopProductsPage> createState() => _DesktopProductsPageState();
}

class _DesktopProductsPageState extends State<DesktopProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('PRODUCTS'),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 4)),
          Expanded(flex: 6, child: Text('Products'))
        ],
      ),
    );
  }
}
