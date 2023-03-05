import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyAppDemo());
}

class MyAppDemo extends StatefulWidget {
  const MyAppDemo({Key? key}) : super(key: key);

  @override
  State<MyAppDemo> createState() => _MyAppDemoState();
}

class _MyAppDemoState extends State<MyAppDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: GoRouter(routes: [
      GoRoute(
          path: '/me',
          builder: (BuildContext context, GoRouterState state) {
            return const MyHomePage(title: 'ME');
          },
          routes:[GoRoute(
              path: 'you',
              builder: (BuildContext context, GoRouterState state) {
                return const MyHomePage(title: 'YOU');
              },
          ),]
          ),
    ]));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my app',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Flutter '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
    100
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: w < 550 ? 1 : 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
              addRepaintBoundaries: true,
              itemCount: items.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  color: w < 600
                      ? Colors.blue[items[index]]
                      : Colors.red[items[index]],
                  child: Text('$w'),
                );
              })

          // child: ListView.separated(
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         // padding: EdgeInsets.all(12),
          //         height: 50,
          //         color: Colors.pink[items[index]],
          //       );
          //     },
          //     separatorBuilder: (BuildContext context, int index) =>
          //         const Divider(),
          //     itemCount: items.length,
          //     padding: EdgeInsets.all(12),
          // )
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.remove),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
