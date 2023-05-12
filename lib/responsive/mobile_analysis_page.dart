import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';

import '../chart.dart';
import '../linechart.dart';
import '../piechart.dart';

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
        backgroundColor: Color.fromARGB(255, 27, 27, 27),
      bottomNavigationBar: myBottomNavigationBar(context,1),
      body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BarChartSample2(
                name: 'order',
              ),
              BarChartSample2(
                name: 'stock',
              ),
              Flexible(child: LineChartSample2()),
              SizedBox(width: 250, height: 200, child: PieChartSample2()),
            ],
          ),
        ));
  }
}
