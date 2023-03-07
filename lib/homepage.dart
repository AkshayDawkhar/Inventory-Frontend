import 'package:flutter/material.dart';
import 'routes.dart';
import 'bottom_nav_bar.dart';

class MyAppDemo extends StatefulWidget {
  const MyAppDemo({Key? key}) : super(key: key);

  @override
  State<MyAppDemo> createState() => _MyAppDemoState();
}

class _MyAppDemoState extends State<MyAppDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: goRouter);
  }
}

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
    100,900,
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
    100,900,
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
    100,900,
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

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    int a =1;

    return Scaffold(
      bottomNavigationBar: BottomNavbBar(context,a),
      drawer: w < 600
          ? const Drawer(
              child: Text('hi'),
            )
          : const Drawer(
              child: Text('no hi'),
            ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
              padding: EdgeInsets.all(12),
              itemBuilder: (BuildContext context, int index) {
              print(index);
                return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  color: w < 600
                      ? Colors.blue[items[index]]
                      : Colors.red[items[index]],
                  child: Text('${DateTime.now()}'),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.remove),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
