import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory/helper.dart';
import 'package:inventory/responsive/desktop_account_page.dart';
import 'package:numeral/numeral.dart';
import 'package:http/http.dart' as http;

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
String s = '${HttpHelper.HOSTNAME}/product/';

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
                style: TextStyle(color: selected == 0 ? Colors.black : Colors.blueGrey[500]),
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
                style: TextStyle(color: selected == 1 ? Colors.black : Colors.blueGrey[500]),
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
                style: TextStyle(color: selected == 2 ? Colors.black : Colors.blueGrey[500]),
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
                style: TextStyle(color: selected == 3 ? Colors.black : Colors.blueGrey[500]),
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
                style: TextStyle(color: selected == 4 ? Colors.black : Colors.blueGrey[500]),
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
                style: TextStyle(color: selected == 5 ? Colors.black : Colors.blueGrey[500]),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                return GoRouter.of(context).go('/login');
              },
              leading: Icon(
                Icons.logout,
                color: selected == 5 ? Colors.black : Colors.blueGrey[500],
              ),
              title: Text(
                'L O G O U T',
                style: TextStyle(color: selected == 5 ? Colors.black : Colors.blueGrey[500]),
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

myContainer(BuildContext context, bool mobile, int index, String pid, String name) {
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
              decoration: BoxDecoration(color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(12)),
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
                                style: TextStyle(color: Colors.white, fontSize: mobile ? 30 : 40, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'InStock: ',
                                        style: TextStyle(color: Colors.white, fontSize: mobile ? 15 : 20),
                                      ),
                                      Text(
                                        Numeral(snapshot.data['instock']).format(),
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: mobile ? 40 : 50, color: Colors.greenAccent, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 12,),
                                  Row(
                                    children: [
                                      Text(
                                        'Building: ',
                                        style: TextStyle(color: Colors.white, fontSize: mobile ? 15 : 20),
                                      ),
                                      Text(
                                        snapshot.data['building'].toString(),
                                        style: TextStyle(
                                            fontSize: mobile ? 40 : 50, color: Colors.black, fontWeight: FontWeight.bold),
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
        Icons.list_alt_rounded,
      ),
      label: 'products'),
// BottomNavigationBarItem(icon: Icon(Icons.add_box,color: Colors.blueGrey,), label: 'create'),
];

Widget myContainer1(BuildContext context, String name, String pid) {
  Future a = HttpHelper().fetchItem(pid);
  return InkWell(
    onTap: () {
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
                  image: DecorationImage(
                    image: NetworkImage('${HttpHelper.HOSTNAME}/static/$pid.png'),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          FutureBuilder(
              future: a,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                } else {
                  return Container(
                    padding: EdgeInsets.all(15),
                    child: Text('loading...'),
                  );
                }
              }),
        ],
      ),
    ),
  );
}

Widget myTrashContainer(BuildContext context, String name, String pid, int ttl) {
  int days = (ttl / 86400).toInt();
  // Future a = HttpHelper().fetchItem(pid);
  return Container(
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
        Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
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
                  Text(
                    // "${Numeral(instock).format()} InStock  ",
                    "$days days ",
                    style: TextStyle(color: days > 10 ? Colors.green : Colors.red),
                  ),
                ],
              ),
            ),
            InkWell(
              child: Icon(Icons.repeat),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Restore'),
                      );
                    });
              },
            ),
            InkWell(
              child: Icon(
                Icons.delete,
                color: Colors.red[400],
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('$name will be deleted permanently'),
                        title: Text('Delete'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              remove(context);
                            },
                            child: Text('cancel'),
                            // style: TextButton.styleFrom(
                            //     foregroundColor:
                            //     Colors
                            //         .red),
                          ),
                          TextButton(
                            onPressed: () async {
                              remove(context);
                              int a = await HttpHelper().deleteTrash(pid);
                              // if (a == 200) {
                              //   return showDialog(
                              //       context: context,
                              //       builder: (context) {
                              //         return AlertDialog(
                              //           title: Text('Deletes successfully'),
                              //         );
                              //       });
                              // }
                            },
                            child: Text('delete'),
                            style: TextButton.styleFrom(foregroundColor: Colors.red),
                          )
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ],
    ),
  );
}

void remove(context) {
  Navigator.of(context).pop();
}

class UserInfoDialog extends StatefulWidget {
  const UserInfoDialog({Key? key, required this.mode}) : super(key: key);
  final String mode;

  @override
  State<UserInfoDialog> createState() => _UserInfoDialogState();
}

class _UserInfoDialogState extends State<UserInfoDialog> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create $mode"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: "First Name",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your first name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lastNameController,
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  return TextEditingValue(text: newValue.text.toLowerCase(), selection: newValue.selection);
                })
              ],
              decoration: InputDecoration(
                labelText: "Last Name",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your last name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email address";
                }
                if (!value.contains("@")) {
                  return "Please enter a valid email address";
                }
                return null;
              },
            ),
            TextFormField(
              onTap: () {},
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a username";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a password";
                }
                if (value.length < 8) {
                  return "Password must be at least 8 characters long";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () async {
            print('clicked');
            // await createAdmin(context);
            // Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.green),
          child: Text("create"),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              String firstName = _firstNameController.text;
              String lastName = _lastNameController.text;
              String email = _emailController.text;
              String username = _usernameController.text;
              String password = _passwordController.text;
              // Do something with the user's information, such as save it to a database
              // Navigator.of(context).pop();
              createAdmin(context, firstName, lastName, username, password, email);
            }
          },
        ),
      ],
    );
  }
}

Future<int> createAdmin(BuildContext context, String f_name, String l_name, String username, String password, String mail) async {
  http.Response a = await HttpHelper().createAdmin(f_name, l_name, username, password, mail);
  // final body = jsonDecode(a.body);
  if (a.statusCode == 201) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green[500],
            title: Text(
              'Created sucessfully',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
          );
        });
  } else if (a.statusCode == 208) {
    final body = jsonDecode(a.body);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // iconColor: Colors.white,
            // titleTextStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.red[500],
            title: Text(
              body['error'][0].toString(),
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.highlight_remove,
              color: Colors.white,
            ),
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // iconColor: Colors.white,
            // titleTextStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.red[500],
            title: Text(
              'some thing went wrong',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.highlight_remove,
              color: Colors.white,
            ),
          );
        });
  }
  return 2;
}

AlertDialog somethingWentWrong = const AlertDialog(
  icon: Icon(
    Icons.close,
    color: Colors.white,
  ),
  title: Text(
    'Something Went Wrong',
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.redAccent,
);

AlertDialog deletedSuccessfully = const AlertDialog(
  icon: Icon(
    Icons.done,
    color: Colors.white,
  ),
  title: Text(
    'Deleted Successfully',
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.greenAccent,
);

class dialogForOrder extends StatefulWidget {
  const dialogForOrder({Key? key, required this.pid}) : super(key: key);
  final pid;

  @override
  State<dialogForOrder> createState() => _dialogForOrderState();
}

class _dialogForOrderState extends State<dialogForOrder> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _continuityController = TextEditingController();
  DateTime dateTime = DateTime.now();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add order'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onTap: () {},
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: _continuityController,
              decoration: InputDecoration(
                labelText: "continuity",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter continuity";
                }
                int continuity = int.parse(value);
                if (continuity < 1) {
                  return "More Than 0";
                }
                return null;
              },
            ),
            TextFormField(
              readOnly: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a Date";
                }
                return null;
              },
              controller: _dateController,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(Duration(hours: 3)),
                  firstDate: DateTime.now().add(Duration(hours: 3)),
                  lastDate: DateTime(2100),
                ).then((value) {
                  setState(() {
                    dateTime = value!;
                  });
                  _dateController.text = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                  print('setting state');
                });
              },
              decoration: InputDecoration(
                labelText: "Date",
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            remove(context);
          },
          child: Text('cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              int continuity = int.parse(_continuityController.text);
              // remove(context);
              createOrder(context, widget.pid, continuity, dateTime);
            }
          },
          child: Text('Save'),
          style: TextButton.styleFrom(foregroundColor: Colors.greenAccent),
        )
      ],
    );
  }
}

Future<int> createOrder(BuildContext context, String pid, int continuity, DateTime date) async {
  int status = await HttpHelper().createOrder(pid, continuity, date);
  showDialog(
      context: context,
      builder: (context) {
        return status == 200
            ? AlertDialog(
                title: Text(
                  'Successfully Pace Order',
                ),
                icon: Icon(
                  Icons.done,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).go('/order');
                    },
                    child: Text('View'),
                  ),
                  TextButton(
                      onPressed: () {
                        // remove(context);
                        // remove(context);
                        GoRouter.of(context).refresh();
                      },
                      child: Text('Ok')),
                ],
              )
            : AlertDialog(
                title: Text(
                  'Something Went Wrong',
                  style: TextStyle(color: Colors.redAccent),
                ),
                icon: Icon(
                  Icons.close_outlined,
                  color: Colors.redAccent,
                ),
              );
      });

  return 1;
}

class mySlider extends StatefulWidget {
  const mySlider({super.key, required this.max, required this.recommended, required this.name, required this.pid});

  final String name;
  final int max;
  final int recommended;
  final String pid;

  @override
  State<mySlider> createState() => _mySliderState();
}

class _mySliderState extends State<mySlider> {
  double _currentSliderValue = 20;
  TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _numberController.text = widget.recommended.toString();
    _currentSliderValue = widget.recommended.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    double max = widget.max.toDouble();
    int recommnded = widget.recommended.toInt();
    String name = widget.name;
    return AlertDialog(
      title: Text('Add $name'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'numbers'),
            autofocus: true,
            controller: _numberController,
            onChanged: (value) {
              double value1 = double.parse(value);
              if (value1 >= max) {
                value1 = max;
                _numberController.text = value1.toString();
              }
              _currentSliderValue = value1;

              setState(() {});
            },
          ),
          Slider(
            value: _currentSliderValue,
            max: max.toDouble(),
            // divisions: 5,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value.round().toDouble();
                _numberController.text = _currentSliderValue.toString();
              });
            },
          ),
        ],
      ),
      // TextFormField(
      //   decoration: InputDecoration(labelText: 'build number'),
      // ),
      actions: [
        TextButton(
            onPressed: () {
              remove(context);
            },
            child: Text('cancel')),
        TextButton(
            onPressed: () async {
              remove(context);
              int i = 0;
              if (name == 'Build') {
                i = await buildItem(context, widget.pid, _currentSliderValue);
              } else if (name == 'Stock') {
                i = await stockItem(context, widget.pid, _currentSliderValue);
              }
            },
            child: Text('Add')),
      ],
    );
  }
}

Future<int> buildItem(BuildContext context, String pid, double buildNo) async {
  int statusCode = await HttpHelper().addBuild(pid, buildNo.toInt());
  print('build -----------> $statusCode');
  if (statusCode == 200) {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('product added to build successfully'),
            actions: [
              TextButton(
                  onPressed: () {
                    remove(context);
                    remove(context);
                    GoRouter.of(context).refresh();
                  },
                  child: Text('ok'))
            ],
          );
        });
  }
  return 12;
}

Future<int> stockItem(BuildContext context, String pid, double stockNo) async {
  int statusCode = await HttpHelper().addStock(pid, stockNo.toInt());
  print('stock ---------> $statusCode');
  if (statusCode == 226) {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('product added to stock successfully'),
            actions: [
              TextButton(
                  onPressed: () {
                    remove(context);
                    remove(context);
                    GoRouter.of(context).refresh();
                  },
                  child: Text('ok'))
            ],
          );
        });
  }
  return 12;
}

BottomNavigationBar myBottomNavigationBar(BuildContext context, int index) => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.blueGrey[700],
      currentIndex: index,
      onTap: (index) {
        print(index);
        if (index == 0) {
          GoRouter.of(context).go('/home');
        } else if (index == 1) {
          GoRouter.of(context).go('/analysis');
        } else if (index == 2) {
          GoRouter.of(context).go('/order');
        } else if (index == 3) {
          GoRouter.of(context).go('/product');
        }
//         setState(() {
//           _currentIndex = aa;
// // GoRouter.of(context).go('/analysis');
//         });
// return GoRouter.of(context).go('/you/${aa + 1}');
// return context.go('you/12');
      },
      items: bottomNavigationBarItems,
    );

List<String> categoryItems =<String>[
  'power amplifiers',
  'installation-speakers',
  'microphones',
  'media player',
  'headphone',
  'subwoofers',
  'setup-wiring'
];
