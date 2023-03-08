import 'package:flutter/material.dart';
import 'routes.dart';
import 'bottom_nav_bar.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';


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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery
        .of(context)
        .size
        .width;
    int a = 1;
    SideMenuController page= SideMenuController();
    List<SideMenuItem> sideitems = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: 'Dashboard',
        // onTap: (){},
        icon: Icon(Icons.home),
        badgeContent: Text(
          '3',
          style: TextStyle(color: Colors.white),
        ),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Settings',
        // onTap: (){},
        icon: Icon(Icons.settings),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Exit',
        // onTap: (){},
        icon: Icon(Icons.exit_to_app),
      ),
    ];
    return w < 1000 ? Scaffold(
      bottomNavigationBar: BottomNavbBar(context, a),
      // endDrawer: Drawer(child: Icon(Icons.send_time_extension),),
      drawer: w < 600
          ? const Drawer(
        child: Text('hii'),
      )
          : const Drawer(
        child: Text('no hi'),
      ),
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person))],
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          SideMenu(
            // Page controller to manage a PageView
            controller: page,
            // Will shows on top of all items, it can be a logo or a Title text
            // title: Image.asset('assets/images/easy_sidemenu.png'),
            // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
            footer: const Text('demo'),
            // Notify when display mode changed
            onDisplayModeChanged: (mode) {
              print(mode);
            },
            style: SideMenuStyle(
              openSideMenuWidth: 200
            ),
            // List of SideMenuItem to show them on SideMenu
            items: sideitems,
          ),
          Expanded(
            child: Center(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: w < 750 ? 1 : 2,
                      childAspectRatio: 4 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                    addRepaintBoundaries: true,
                    addAutomaticKeepAlives: true,
                    itemCount: items.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (BuildContext context, int index) {
                      print(index);
                      return Container(
                        alignment: Alignment.center,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        color: w < 600
                            ? Colors.blue[items[index]]
                            : Colors.red[items[index]],
                        child: Text('${DateTime.now()}'),
                      );
                    })),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.handyman),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ):body(context, widget);
  }
}

Widget body(BuildContext context, final widget) =>
    Scaffold(
      bottomNavigationBar: BottomNavbBar(context, 1),
      // endDrawer: Drawer(child: Icon(Icons.send_time_extension),),
      drawer: const Drawer(child: Text('no hi')),
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person))],
        title: Text(widget.title.toString()),
      ),
      body: Center(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
              addRepaintBoundaries: true,
              addAutomaticKeepAlives: true,
              itemCount: items.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (BuildContext context, int index) {
                print(index);
                return Container(
                  alignment: Alignment.center,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  color: Colors.red[items[index]],
                  child: Text('${DateTime.now()}'),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.handyman),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
