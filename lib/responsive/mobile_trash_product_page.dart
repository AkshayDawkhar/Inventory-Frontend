import 'package:flutter/material.dart';
import '/constants.dart';

class MobileTrashProductPage extends StatelessWidget {
  final String title;
  const MobileTrashProductPage({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
