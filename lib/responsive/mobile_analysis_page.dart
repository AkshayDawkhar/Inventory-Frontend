import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

class MobileAnalysis extends StatefulWidget {
  const MobileAnalysis({Key? key}) : super(key: key);

  @override
  State<MobileAnalysis> createState() => _MobileAnalysisState();
}

class _MobileAnalysisState extends State<MobileAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('ANALYSIS'),
      drawer: myDrawer(context, 1),
      body: Text('analysis'),

    ) ;
  }
}
