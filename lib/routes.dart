import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'responsive/responsive_layout.dart';
import 'responsive/desktop_scaffold.dart';
import 'responsive/mobile_scaffold.dart';
import 'responsive/mobile_product_page.dart';
import 'responsive/desktop_product_page.dart';
import 'responsive/desktop_home_page.dart';
import 'responsive/mobile_home_page.dart';

GoRouter goRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: DesktopScaffold(body: desktopHomepageBody,),
            mobileScaffold: MobileScaffold(body:mobileHomepageBody ,));
      }),
  GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: DesktopScaffold(body: desktopHomepageBody,),
            mobileScaffold: MobileScaffold(body:mobileHomepageBody ,));
      }),

  GoRoute(
      path: '/product/:me',
      builder: (BuildContext context, GoRouterState state) {
        String me = state.params['me']!;
        return ResponsiveLayout(
            desktopScaffold: DesktopScaffold(body:DesktopProductPage(title: me)),
            mobileScaffold:  MobileScaffold(body: MobileProductPage(title: me,)));
      })
]);
