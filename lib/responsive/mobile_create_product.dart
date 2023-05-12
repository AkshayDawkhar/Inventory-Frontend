
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/constants.dart';
import 'package:http/http.dart' as http;
import 'package:inventory/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory/helper.dart';

class MobileCreateProductPage extends StatefulWidget {
  const MobileCreateProductPage({super.key, required this.title});

  final String title;

  @override
  State<MobileCreateProductPage> createState() => _MobileCreateProductPageState();
}

class _MobileCreateProductPageState extends State<MobileCreateProductPage> {

    ImagePicker picker = ImagePicker();
    XFile? image;

    // List<int> selected = [];
    // List<int> select = [11,12,44,333,23,22, 21, 31, 41, 51, 61];
    List<int> selectedNumber = [];
    Future<List> items = HttpHelper().fetchItems();
    List<Map> selected = [];
    List select = [];
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final colorController = TextEditingController();

    final selectedController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    int count = 8;

    @override
    Widget build(BuildContext context) {
      if (colorController.text.isEmpty) {
        colorController.text = 'black';
      }
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      void remove() {
        Navigator.of(context).pop();
      }
    return Scaffold(
      drawer: myDrawer(context, 4),
      appBar: myAppBar('NEW'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // setState(() {});
          if (formKey.currentState!.validate()) {
            int aa = await HttpHelper()
                .createItem(nameController.text, categoryController.text, colorController.text, selected, selectedNumber);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
          }
        },
        backgroundColor: Colors.blueGrey,
        icon: Icon(
          Icons.arrow_forward,
          size: 30,
        ),
        label: Text('Submit'),
      ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              alignment: Alignment.topCenter,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {
                        //update UI
                      });
                    },
                    child: Container(
                      color: Colors.blueGrey,
                      width: width / 5,
                      height: width / 5,
                      child: Center(child: image == null ? Text('Select Image') : Text(image!.name)),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(labelText: 'Product Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter name';
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          child: TextFormField(
                            controller: categoryController,
                            decoration: InputDecoration(labelText: 'Category'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Category';
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          child: TextFormField(
                            controller: colorController,
                            // initialValue: "black",
                            decoration: InputDecoration(labelText: 'Color'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter name';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      'required',
                      textAlign: TextAlign.right,
                      // style: TextStyle(fontSize: width / 80
                    ),
                  ),
          Container(
            color: Colors.blueGrey[100],
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            child: selected.isNotEmpty
                ? GridView.builder(
                itemCount: selected.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: width < 1000 ? 2 : 4),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print(index);
                        showDialog(
                            context: context,
                            builder: (context) {
                              selectedController.text = selectedNumber[index].toString();
                              return AlertDialog(
                                title: Text('${selected[index]['dname']}'),
                                // icon: const Icon(Icons.),
                                content: TextFormField(
                                  autofocus: true,

                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    TextInputFormatter.withFunction((oldValue, newValue) {
                                      // Disallow values that start with 0
                                      if (newValue.text.startsWith('0')) {
                                        return oldValue;
                                      }

                                      try {
                                        final int parsed = int.parse(newValue.text);
                                        if (parsed < 1) {
                                          return oldValue;
                                        }
                                        return newValue.copyWith(text: parsed.toString());
                                      } on FormatException catch (exe) {
                                        print(exe);
                                        return newValue;
                                      } catch (exe) {
                                        print(exe);
                                        return oldValue;
                                      }
                                    }),
                                  ],
                                  // initialValue:
                                  //     '${selectedNumber[index]}',
                                  controller: selectedController,
                                  keyboardType: TextInputType.number,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        select.add(selected.removeAt(index));
                                        selectedNumber.removeAt(index);
                                        remove();
                                        setState(() {});
                                      },
                                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                                      child: Text(
                                        'Remove',
                                        // style: TextStyle(
                                        //     // color: Colors.red
                                        //     ),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        print(selectedController.text);
                                        selectedNumber[index] = int.parse(selectedController.text);
                                        remove();
                                        setState(() {});
                                      },
                                      style: TextButton.styleFrom(foregroundColor: Colors.green),
                                      child: Text('OK')),
                                ],
                              );
                            });
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.blueGrey),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${HttpHelper.HOSTNAME}/static/${selected[index]['pid']}.png'),
                                fit: BoxFit.fill)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Text(
                                '${selectedNumber[index]}',
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.green, fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: Colors.blueGrey.withOpacity(0.5),
                                ),
                                child: Center(child: Text('${selected[index]['dname']}'))),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                : const Center(child: Text('No item selected')),

          ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: const Text(
                      'select',
                      textAlign: TextAlign.right,
                      // style: TextStyle(fontSize: width / 80
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(12),
                    color: Colors.blueGrey[50],
                    child: FutureBuilder(
                        future: items,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            select = snapshot.data!;
                            return GridView.builder(
                                itemCount: select.length,
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: width < 1000 ? 3 : 5),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        print(index);
                                        selected.add(select.removeAt(index));
                                        // selected.add(snapshot.data![index]);
                                        print(selected);
                                        selectedNumber.add(1);
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 3, color: Colors.red),
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                            image:  DecorationImage(
                                                image: NetworkImage(
                                                    '${HttpHelper.HOSTNAME}/static/${snapshot.data![index]['pid']}.png'),
                                                fit: BoxFit.fill)),
                                        child: Text('${snapshot.data![index]['dname']}'),
                                      ),
                                    ),
                                  );
                                });
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                  ),

                ],
              )),
        ),
        bottomNavigationBar: myBottomNavigationBar(context,3)

    );
  }
}
