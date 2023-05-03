import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';
import 'package:inventory/helper.dart';
import 'package:inventory/chart.dart';
import 'package:inventory/piechart.dart';
import 'package:inventory/linechart.dart';

class DesktopAnalysis extends StatefulWidget {
  const DesktopAnalysis({Key? key}) : super(key: key);

  @override
  State<DesktopAnalysis> createState() => _DesktopAnalysisState();
}

class _DesktopAnalysisState extends State<DesktopAnalysis> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: myAppBar('ANALYSIS'),
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: Row(
        children: [
          Expanded(flex: 1, child: myDrawer(context, 1)),
          Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: width / 2.5,
                            height: 480,
                            child: BarChartSample2(
                              name: 'order',
                            )),
                        SizedBox(
                            width: width / 2.5,
                            height: 480,
                            child: BarChartSample2(
                              name: 'stock',
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(child: LineChartSample2()),
                        SizedBox(width: 250, height: 200, child: PieChartSample2()),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
