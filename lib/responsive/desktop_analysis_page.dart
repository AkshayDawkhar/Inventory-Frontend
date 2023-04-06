import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class DesktopAnalysis extends StatefulWidget {
  const DesktopAnalysis({Key? key}) : super(key: key);

  @override
  State<DesktopAnalysis> createState() => _DesktopAnalysisState();
}

class _DesktopAnalysisState extends State<DesktopAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('ANALYSIS'),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 1)),
          Expanded(flex: 6, child: Text('analysis'))
        ],
      ),
    );
  }
}
