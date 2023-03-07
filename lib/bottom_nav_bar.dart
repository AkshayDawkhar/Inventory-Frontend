import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget BottomNavbBar(BuildContext context,int a) => BottomNavigationBar(
    selectedItemColor:Colors.red,
      currentIndex:a ,
      onTap: (aa){
      print(aa);
      return GoRouter.of(context).go('/you/${aa + 1}');
      // return context.go('you/12');
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: '',backgroundColor: Colors.pink,
        ),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'public'),
        BottomNavigationBarItem(icon: Icon(Icons.build), label: 'builds'),
      ],
    );
