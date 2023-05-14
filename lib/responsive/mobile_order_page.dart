import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../helper.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
class MobileOrderPage extends StatefulWidget {
  const MobileOrderPage({Key? key}) : super(key: key);

  @override
  State<MobileOrderPage> createState() => _MobileOrderPageState();
}

class _MobileOrderPageState extends State<MobileOrderPage> {
  late Future<List> items;
  DateTime today = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _continuityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String appbarTittle = '';

  void setAppbarTittleDate() {
    appbarTittle = '${today.day}/${today.month}/${today.year}';
  }

  void setAppbarTittleName(String name) {
    appbarTittle = name;
  }

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // items= ;
    setAppbarTittleDate();
    items = HttpHelper().fetchOrder();
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LiquidPullToRefresh(
      color: Colors.blueGrey[300],
      height: 150,
      backgroundColor: Colors.blueGrey,
      springAnimationDurationInMilliseconds: 500,
      onRefresh: ()async{
        print('refrash');
        await Future.delayed(Duration(seconds: 1));
        GoRouter.of(context).refresh();
      },
      child: Scaffold(
        appBar: myAppBar('ORDERS'),
        drawer: myDrawer(context, 2),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TableCalendar(
                focusedDay: today,
                selectedDayPredicate: (day) => isSameDay(day, today),
                headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
                calendarStyle: CalendarStyle(selectedDecoration: BoxDecoration(color: Colors.blueGrey, shape: BoxShape.circle)),
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 1, 1),
                onDaySelected: (day, time) {
                  setState(() {
                    today = day;
                    print(today);
                    setAppbarTittleDate();
                  });
                },
              ),
              Divider(),
              FutureBuilder(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.blueGrey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Name',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '  Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'continuity',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'edit',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'complete',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              itemCount: snapshot.data!.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Map data = snapshot.data![index];
                                DateTime dateTime = DateTime.parse(data['timestamp']);
                                String day = dateTime.day.toString();
                                String month = dateTime.month.toString();
                                String year = dateTime.year.toString();
                                String pid = data['pid'];
                                String numbers = data['numbers'].toString();
                                String name = '';
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[100], borderRadius: BorderRadius.all(Radius.circular(12))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: InkWell(
                                          child: FutureBuilder(
                                              future: HttpHelper().fetchItemName(pid),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  name = snapshot.data['dname'].toString();
                                                  return Text('${snapshot.data['dname']}');
                                                } else {
                                                  return Text('name');
                                                }
                                              }),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    // title: Text('name'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            setAppbarTittleName(name.toString());
                                                            setState(() {});
                                                            remove(context);
                                                          },
                                                          child: Text('view all orders')),
                                                      TextButton(
                                                          onPressed: () {
                                                            GoRouter.of(context).push('/product/$pid');
                                                          },
                                                          child: Text('view product')),
                                                    ],
                                                  );
                                                });
                                            // GoRouter.of(context)
                                            //     .push('/product/$pid');
                                          },
                                        ),
                                      ),
                                      Text('$day/$month/$year'),
                                      Text(numbers),
                                      InkWell(
                                        child: Icon(Icons.edit),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                _dateController.text = '$day/$month/$year';
                                                _continuityController.text = numbers;
                                                return AlertDialog(
                                                  title: Text('Edit'),
                                                  content: Form(
                                                    key: formKey,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        TextFormField(
                                                          readOnly: true,
                                                          controller: _dateController,
                                                          onTap: () {
                                                            showDatePicker(
                                                              context: context,
                                                              initialDate: dateTime,
                                                              firstDate: DateTime(2000),
                                                              lastDate: DateTime(2100),
                                                            ).then((value) {
                                                              setState(() {
                                                                dateTime = value!;
                                                              });
                                                              _dateController.text =
                                                                  '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                                                              print('setting state');
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                            labelText: "Date",
                                                          ),
                                                        ),
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
                                                              return "Please enter a username";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Text('Delete'),
                                                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (formKey.currentState!.validate()) {}
                                                        },
                                                        child: Text('Save'))
                                                  ],
                                                );
                                              });
                                        },
                                      ),
                                      // IconButton(onPressed: (){}, icon: Icon(Icons.done))
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('complete Order'),
                                                  content: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'continuity',
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(onPressed: () {}, child: Text('cancel')),
                                                    TextButton(onPressed: () {}, child: Text('complete'))
                                                  ],
                                                );
                                              });
                                        },
                                        child: Icon(Icons.done),
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.greenAccent)),
                                      )
                                      // TextButton(
                                      //     onPressed: () {}, child: Icon(Icons.done))
                                    ],
                                  ),
                                );
                              }),
                        ],
                      );
                    } else {
                      return Center(child: const CircularProgressIndicator());
                    }
                  }),
              Container(padding: EdgeInsets.all(12), child: Text('completed order')),
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.blueGrey[200],
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '  Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'continuity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: FutureBuilder(
                    future: items,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Map data = snapshot.data![index];
                              DateTime dateTime = DateTime.parse(data['timestamp']);
                              String day = dateTime.day.toString();
                              String month = dateTime.month.toString();
                              String year = dateTime.year.toString();
                              String pid = data['pid'];
                              String numbers = data['numbers'].toString();
                              return Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(12),
                                decoration:
                                    BoxDecoration(color: Colors.blueGrey[100], borderRadius: BorderRadius.all(Radius.circular(12))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 130,
                                      child: InkWell(
                                        child: FutureBuilder(
                                            future: HttpHelper().fetchItemName(pid),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text('${snapshot.data['dname']}');
                                              } else {
                                                return Text('name');
                                              }
                                            }),
                                        onTap: () {
                                          GoRouter.of(context).push('/product/$pid');
                                        },
                                      ),
                                    ),
                                    Text('$day/$month/$year'),
                                    Text(numbers),
                                    // IconButton(onPressed: (){}, icon: Icon(Icons.done))
                                    // TextButton(
                                    //     onPressed: () {}, child: Icon(Icons.done))
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
          bottomNavigationBar: myBottomNavigationBar(context,2)

      ),
    );
  }
}
