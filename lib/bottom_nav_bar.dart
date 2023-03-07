import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget BottomNavbBar(BuildContext context, int a) => BottomNavigationBar (
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.blueGrey[200],
      currentIndex: 0,
      onTap: (aa) {
        print(aa);
        return GoRouter.of(context).go('/you/${aa + 1}');
        // return context.go('you/12');
      },
      items:  const [
        BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.leaderboard,), label: 'analysis'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,), label: 'orders'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box,), label: 'create'),
        // BottomNavigationBarItem(icon: Icon(Icons.add_box,color: Colors.blueGrey,), label: 'create'),
        ],
    );
