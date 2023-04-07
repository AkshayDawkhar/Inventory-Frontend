import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class MobileProductsPage extends StatefulWidget {
  const MobileProductsPage({Key? key}) : super(key: key);

  @override
  State<MobileProductsPage> createState() => _MobileProductsPageState();
}

class _MobileProductsPageState extends State<MobileProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Products'),
      drawer: myDrawer(context, 4),
      body: Text('Products'),

    ) ;
  }
}
