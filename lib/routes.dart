import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'responsive/responsive_layout.dart';
import 'responsive/desktop_scaffold.dart';
import 'responsive/mobile_scaffold.dart';
import 'responsive/mobile_product_page.dart';
import 'responsive/desktop_product_page.dart';
import 'responsive/desktop_home_page.dart';
import 'responsive/mobile_home_page.dart';
import 'responsive/desktop_analysis_page.dart';
import 'responsive/mobile_analysis_page.dart';
import 'responsive/desktop_account_page.dart';
import 'responsive/mobile_account_page.dart';
import 'responsive/desktop_order_page.dart';
import 'responsive/mobile_order_page.dart';
import 'responsive/desktop_products_page.dart';
import 'responsive/mobile_products_page.dart';

GoRouter goRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: DesktopScaffold(),
            mobileScaffold: MobileScaffold(
              body: mobileHomepageBody,
            ));
      }),
  GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: DesktopScaffold(),
            mobileScaffold: MobileScaffold(
              body: mobileHomepageBody,
            ));
      }),
  GoRoute(
      path: '/analysis',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: DesktopAnalysis(),
            mobileScaffold: MobileAnalysis());
      }),
  GoRoute(
      path: '/account',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: DesktopAccountPage(),
            mobileScaffold: MobileAccountPage());
      }),
  GoRoute(
      path: '/order',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: DesktopOrderPage(),
            mobileScaffold: MobileOrderPage());
      }),
  GoRoute(
      path: '/product',
      builder: (BuildContext context, GoRouterState state) {
        return ResponsiveLayout(
            desktopScaffold: DesktopProductsPage(),
            mobileScaffold: MobileProductsPage());
      },
      routes: [
        GoRoute(
            path: ':name',
            builder: (BuildContext context, GoRouterState state) {
              String name = state.params['name']!;
              return ResponsiveLayout(
                  desktopScaffold: DesktopProductPage(
                    title: name,
                  ),
                  mobileScaffold: MobileScaffold(
                      body: MobileProductPage(
                        title: name,
                      )));
            }),
      ],
      ),

]);
