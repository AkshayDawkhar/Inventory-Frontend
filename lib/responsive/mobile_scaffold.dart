import 'package:flutter/material.dart';
import '/constants.dart';
import 'package:go_router/go_router.dart';

class MobileScaffold extends StatefulWidget {
  final Widget body;
  const MobileScaffold({Key? key,required this.body}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer,
      appBar: myAppBar('HOME'),
      body: Center(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
              addRepaintBoundaries: true,
              addAutomaticKeepAlives: true,
              itemCount: items.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (BuildContext context, int index) {
                return myContainer(context,true,index);
              })
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey[700],
        child: Icon(Icons.add),
      ),
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.blueGrey[700],
      currentIndex: _currentIndex,
      onTap: (aa) {
        print(aa);
        setState(() {
          GoRouter.of(context).pushReplacement('/home');
          _currentIndex = aa;
        });
        // return GoRouter.of(context).go('/you/${aa + 1}');
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
    ),
    );
  }
}
