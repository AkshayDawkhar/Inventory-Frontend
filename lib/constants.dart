import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory/helper.dart';
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

myAppBar(String title) => AppBar(
      title: Text(title),
      backgroundColor: Colors.blueGrey[700],
    );
// int ii = 0;
String s = 'http://127.0.0.1:8000/product/';

myDrawer(BuildContext context, int selected) => Drawer(
      // backgroundColor: myBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.circle)),
            ListTile(
              onTap: () {
                return GoRouter.of(context).go('/');
              },
              // hoverColor: Colors.red,
              leading: Icon(
                Icons.home,
                color: selected == 0 ? Colors.black : Colors.blueGrey[500],
              ),
              title: Text(
                'H O M E',
                style: TextStyle(
                    color: selected == 0 ? Colors.black : Colors.blueGrey[500]),
              ),
            ),
            ListTile(
              onTap: () {
                return GoRouter.of(context).go('/analysis');
              },
              leading: Icon(
                Icons.leaderboard,
                color: selected == 1 ? Colors.black : Colors.blueGrey[500],
              ),
              title: Text(
                'A N A L Y S I S',
                style: TextStyle(
                    color: selected == 1 ? Colors.black : Colors.blueGrey[500]),
              ),
            ),
            ListTile(
              onTap: () {
                return GoRouter.of(context).go('/order');
              },
              leading: Icon(
                Icons.shopping_cart,
                color: selected == 2 ? Colors.black : Colors.blueGrey[500],
              ),
              title: Text(
                'O R D E R S',
                style: TextStyle(
                    color: selected == 2 ? Colors.black : Colors.blueGrey[500]),
              ),
            ),
            ListTile(
              onTap: () {
                return GoRouter.of(context).go('/account');
              },
              leading: Icon(
                Icons.account_circle,
                color: selected == 3 ? Colors.black : Colors.blueGrey[500],
              ),
              title: Text(
                'A C C O U N T S',
                style: TextStyle(
                    color: selected == 3 ? Colors.black : Colors.blueGrey[500]),
              ),
            ),
            ListTile(
              onTap: () {
                return GoRouter.of(context).go('/product');
              },
              leading: Icon(
                Icons.list_alt_rounded,
                color: selected == 4 ? Colors.black : Colors.blueGrey[500],
              ),
              title: Text(
                'P R O D U C T S',
                style: TextStyle(
                    color: selected == 4 ? Colors.black : Colors.blueGrey[500]),
              ),
            ),
            ListTile(
              onTap: () {
                return GoRouter.of(context).go('/trash');
              },
              leading: Icon(
                Icons.delete,
                color: selected == 5 ? Colors.black : Colors.blueGrey[500],
              ),
              title: Text(
                'T R A S H',
                style: TextStyle(
                    color: selected == 5 ? Colors.black : Colors.blueGrey[500]),
              ),
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

myContainer(
    BuildContext context, bool mobile, int index, String pid, String name) {
  final a = HttpHelper().fetchItem(pid);
  return FutureBuilder(
      future: a,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () {
              print(snapshot.data);
              GoRouter.of(context).push('/product/${snapshot.data['pid']}');
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(12)),
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
                                begin: Alignment.centerLeft,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: mobile ? 30 : 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'InStock: ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: mobile ? 15 : 20),
                                      ),
                                      Text(
                                        Numeral(snapshot.data['instock'])
                                            .format(),
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: mobile ? 40 : 50,
                                            color: Colors.greenAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 12,),
                                  Row(
                                    children: [
                                      Text(
                                        'Building: ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: mobile ? 15 : 20),
                                      ),
                                      Text(
                                        snapshot.data['building'].toString(),
                                        style: TextStyle(
                                            fontSize: mobile ? 40 : 50,
                                            color: Colors.black,
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
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      });
}

var bottomNavigationBarItems = const [
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
];

Widget myContainer1(BuildContext context,String name,String pid) {

  Future a = HttpHelper().fetchItem(pid);
  return InkWell(
    onTap: (){
      GoRouter.of(context).push('/product/$pid');
    },
    child: Container(

      // padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://static.wixstatic.com/media/256076_689c3b907b5441248756c0b36f553cc4~mv2.jpeg/v1/fill/w_1276,h_727,al_c,q_85,usm_1.20_1.00_0.01,enc_auto/8100.jpeg'),
                    fit: BoxFit.cover,
                  )),

            ),
          ),
          FutureBuilder(
              future:a,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  int instock = snapshot.data['instock'];
                  int building = snapshot.data['building'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.0),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Text(
                          "${Numeral(instock).format()} InStock  ",
                          style: TextStyle(color: Colors.green),
                        ),
                        Icon(
                          Icons.circle,
                          color: Colors.blueGrey,
                          size: 10,
                        ),
                        Text(
                          "  ${Numeral(building).format()} Building  ",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ],
                );

              }else{
                  return Container(padding: EdgeInsets.all(15),child: Text('loading...'),);
                }
              }
          ),
        ],
      ),
    ),
  );
}