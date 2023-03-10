import 'package:flutter/material.dart';
import '/constants.dart';

class MobileProductPage extends StatelessWidget {
  const MobileProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('PRODUCT'),
    );
  }
}
