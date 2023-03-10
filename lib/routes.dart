import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'responsive/responsive_layout.dart';
import 'responsive/desktop_scaffold.dart';
import 'responsive/mobile_scaffold.dart';

GoRouter goRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: const DesktopScaffold(),
            mobileScaffold: const MobileScaffold());
      }),
]);
