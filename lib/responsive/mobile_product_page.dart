import 'package:flutter/material.dart';
import '/constants.dart';

class MobileProductPage extends StatelessWidget {
  final String title;
  const MobileProductPage({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('PRODUCT $title'),
    );
  }
}
