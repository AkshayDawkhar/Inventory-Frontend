import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget desktopScaffold;

  ResponsiveLayout({
    required this.desktopScaffold,
    required this.mobileScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints)
    {
      if (constraints.maxWidth < 500) {
        return mobileScaffold;
      }
      else {
        return desktopScaffold;
      }}
    );
  }
  }
