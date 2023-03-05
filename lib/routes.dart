import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'homepage.dart';

GoRouter goRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: 'ME');
      },
      routes:[
        GoRoute(
          path: 'you/:me',
          builder: (BuildContext context, GoRouterState state) {
            String me = state.params['me']!;
            return  MyHomePage(title: me);
          },
        ),]
  ),
]
);