import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:numeral/numeral.dart';

List<int> items = <int>[
  900,
  900,
  900,
  900,
  900,
  900,
  800,
  700,
  600,
  500,
  400,
  300,
  200,
  100,
  900,
  900,
  900,
  900,
  900,
  900,
  800,
  700,
  600,
  500,
  400,
  300,
  200,
  100,
  900,
  900,
  900,
  900,
  900,
  900,
  800,
  700,
  600,
  500,
  400,
  300,
  200,
  100,
  900,
  900,
  900,
  900,
  900,
  900,
  800,
  700,
  600,
  500,
  400,
  300,
  200,
  100,
];
var myBackgroundColor = Colors.white;

AppBar myAppBar = AppBar(
  backgroundColor: Colors.blueGrey[700],
);

var myDrawer = Drawer(
  // backgroundColor: myBackgroundColor,
  child: SingleChildScrollView(
    child: Column(
      children: const [
        DrawerHeader(child: Icon(Icons.favorite)),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('H O M E'),
        ),
        ListTile(
          leading: Icon(Icons.leaderboard),
          title: Text('A N A L Y S I S'),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('O R D E R S'),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('A C C O U N T S'),
        ),
        ListTile(
          leading: Icon(Icons.list_alt_rounded),
          title: Text('P R O D U C T S'),
        ),
      ],
    ),
  ),
);

myBottomNavBar(BuildContext context) => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.blueGrey[700],
      currentIndex: 0,
      onTap: (aa) {
        print(aa);
        return GoRouter.of(context).go('/you/${aa + 1}');
        // return context.go('you/12');
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.leaderboard,
            ),
            label: 'analysis'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'orders'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
            ),
            label: 'create'),
        // BottomNavigationBarItem(icon: Icon(Icons.add_box,color: Colors.blueGrey,), label: 'create'),
      ],
    );

myContainer(bool mobile, int index) => Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://static.wixstatic.com/media/256076_15225f5ed7654366b363bb856eaf6b62~mv2.jpg/v1/fill/w_520,h_420,al_c,q_85,usm_0.66_1.00_0.01/256076_15225f5ed7654366b363bb856eaf6b62~mv2.webp'),
                      fit: BoxFit.cover,
                    )),
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomRight,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'InStock',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: mobile ? 15 : 20),
                              ),
                              Text(
                                Numeral(items[index]).format(),
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: mobile ? 40 : 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // SizedBox(height: 12,),
                          Column(
                            children: [
                              Text(
                                'Building',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: mobile ? 15 : 20),
                              ),
                              Text(
                                '$index',
                                style: TextStyle(
                                    fontSize: mobile ? 40 : 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          // Expanded(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Column(
          //         children: [
          //           Text(
          //             Numeral(items[index] + 1500000).format(),
          //             // overflow: TextOverflow.ellipsis,
          //             style: TextStyle(
          //                 fontSize: mobile ? 40 : 50,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text(
          //             'InStock',
          //             style: TextStyle(fontSize: mobile ? 15 : 20),
          //           ),
          //         ],
          //       ),
          //       // SizedBox(height: 12,),
          //       Column(
          //         children: [
          //           Text(
          //             '$index',
          //             style: TextStyle(
          //                 fontSize: mobile ? 40 : 50,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text(
          //             'Building',
          //             style: TextStyle(fontSize: mobile ? 15 : 20),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
