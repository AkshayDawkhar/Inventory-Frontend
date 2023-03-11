import 'package:flutter/material.dart';
import '/constants.dart';

class DesktopProductPage extends StatelessWidget {
  const DesktopProductPage({super.key, required this.title});
  final title;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title),);
  }
}
