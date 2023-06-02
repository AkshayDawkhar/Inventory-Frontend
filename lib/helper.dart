import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static String HOSTNAME = 'http://192.168.43.45:8000';
  Future<List> fetchItems() async {
    List<Map> items = [{}, {}];
    // Uri url = Uri.parse('$HOSTNAME/product/');
    // final a = await http.get(url);

    final url = Uri.parse('$HOSTNAME/product/');
    // await Future.delayed(Duration(seconds: 1));
    final a = await http.get(url);
    print(a.statusCode);
    final json = jsonDecode(a.body);
    return json;
  }

  Future<List> fetchCategoryItems(String category) async {

    final url = Uri.parse('$HOSTNAME/product/?category=$category');
    print(url);
    final responce = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // body: jsonEncode({
        //   "category":category
        // })
        );
    final a = await http.get(url);
    print(a.body);
    final json = jsonDecode(a.body);
    return json;
  }
  Future fetchItem(String pid) async {
    // await Future.delayed(Duration(seconds: 4));
    final url = Uri.parse('$HOSTNAME/build/edit/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future fetchItemName(String pid) async {
    // await Future.delayed(Duration(seconds: 5));
    final url = Uri.parse('$HOSTNAME/product/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future createItem(String name, String category, String color,
      List requiredItems, List requiredItemsNo) async {
    final url = Uri.parse('$HOSTNAME/product/');
    final requiredItemsId = requiredItems.map((e) => e['pid']).toList();
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "category": category,
          "dname": name,
          "color": color,
          "required_items": requiredItemsId,
          "required_items_no": requiredItemsNo
        }));
    print(responce.body);
    return 1;
  }

  Future<List> fetchRequired(String pid) async {
    // await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$HOSTNAME/build/required/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future fetchItem1(String pid) async {
    // await Future.delayed(Duration(seconds: 4));
    final url = Uri.parse('$HOSTNAME/product/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('______________-----_____________');
    print(json);
    return json;
  }

  Future<List> fetchNeeded(String pid) async {
    // await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$HOSTNAME/build/needed/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future<int> fetchMax(String pid) async {
    // await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$HOSTNAME/build/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future<int> deleteproduct(String pid) async {
    // await Future.delayed(Duration(seconds: 6));
    final url = Uri.parse('$HOSTNAME/product/$pid');
    final a = await http.delete(url);
    final json = jsonDecode(a.body);
    print('------------> ${a.statusCode}');
    return a.statusCode;
  }

  Future<List> fetchTrashProduct() async {
    // await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$HOSTNAME/product/trash/');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('trash product -----------> $json');
    return json;
  }

  Future<int> deleteTrash(String pid) async {
    // await Future.delayed(Duration(seconds: 6));
    final url = Uri.parse('$HOSTNAME/product/trash/$pid');
    final a = await http.delete(url);
    final json = jsonDecode(a.body);
    print('------------> ${a.statusCode}-->${a.body}');
    return a.statusCode;
  }

  Future<int> restoreTrash(String pid) async {
    // await Future.delayed(Duration(seconds: 6));
    final url = Uri.parse('$HOSTNAME/product/trash/$pid');
    final a = await http.post(url);
    final json = jsonDecode(a.body);
    print('------------> ${a.statusCode}-->${a.body}');
    return a.statusCode;
  }

  Future<List> fetchAccount() async {
    // await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$HOSTNAME/account/');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('account -----------> $json');
    return json;
  }

  Future<List> fetchAdmin() async {
    // await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$HOSTNAME/account/admin/');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('admin -----------> $json');
    return json;
  }

  Future<http.Response> createAccount(String mode,String fName,String lName, String username,String password,String mail) async {
    // String f_name = 'akshayqwqw';
    // String l_name = 'dawkharqwqw';
    // String username = 'akshaydawkhar2qwqw';
    // String password = 'akshaydawkhar2qwqw';
    // String mail = 'akshay@gmail.comcom';
    // await Future.delayed(Duration(seconds: 1));

    final url = mode == 'admin' ?Uri.parse('$HOSTNAME/account/admin/'):Uri.parse('$HOSTNAME/account/');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "f_name": fName,
          "l_name": lName,
          "username": username,
          "password": password,
          "mail": mail
        }));
    print('creating admin ${responce.body}');
    return responce;
  }
  Future<int> deleteAdmin(String username) async {
    // await Future.delayed(Duration(seconds: 2));
    final url = Uri.parse('$HOSTNAME/account/admin/$username');
    final a = await http.delete(url);
    final json = jsonDecode(a.body);
    print('-----------+++===-> ${a.statusCode}-->${a.body}');
    return a.statusCode;
  }


  Future<int> deleteWorker(String username) async {
    // await Future.delayed(Duration(seconds: 2));
    final url = Uri.parse('$HOSTNAME/account/$username');
    final a = await http.delete(url);
    final json = jsonDecode(a.body);
    print('-----------+++===-> ${a.statusCode}-->${a.body}');
    return a.statusCode;
  }
  Future<int> deleteAccount(String mode, String username) async {
    if(mode == 'admin'){
    return deleteAdmin(username);
    }else if(mode == 'worker'){
      return deleteWorker(username);
    }else{
      return -1;
    }
  }
  Future<List> fetchOrder() async {
    // await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$HOSTNAME/order/');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('orders -----------> $json');
    return json;
  }
  Future<int> createOrder(String pid,int numbers,DateTime date) async {
    // int time =  1681371419;
    date =  date.add(Duration(hours: 5,minutes: 30)); // this code need to remove after fixing backend time format
    int time = date.toUtc().millisecondsSinceEpoch ~/ 1000;
    print(time);
    print(date);
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$HOSTNAME/order/edit/$pid');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "timestamp": time,
          "numbers":numbers
        }));
    print('creating order ${responce.body}');
    return responce.statusCode;
  }
  Future<int> addBuild(String pid,int buildNo) async {
    // int time =  1681371419;

    // await Future.delayed(Duration(seconds: 5));
    final url = Uri.parse('$HOSTNAME/build/$pid');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'build_no':buildNo
        }));
    print('adding build ${responce.body}');
    return responce.statusCode;
  }
  Future<int> addStock(String pid,int stockNo) async {
    // int time =  1681371419;

    // await Future.delayed(Duration(seconds: 5));
    final url = Uri.parse('$HOSTNAME/build/stock/$pid');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'stock_no':stockNo
        }));
    print('adding build ${responce.body}');
    return responce.statusCode;
  }

  Future<List> fetchCategory() async {
    final url = Uri.parse('$HOSTNAME/product/category/');
    final a = await http.get(url);
    await Future.delayed(Duration(seconds: 5));
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }
  Future<int> createCategory(String name) async {
    // int time =  1681371419;
    final url = Uri.parse('$HOSTNAME/product/category/');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
        'category':name
        }));
    print(responce.statusCode);
    return responce.statusCode;
  }
  Future<List> fetchBuildingItems() async {
    final url = Uri.parse('$HOSTNAME/build/building');
    // await Future.delayed(Duration(seconds: 1));
    final a = await http.get(url);
    print(a.statusCode);
    print(a.body);
    final json = jsonDecode(a.body);
    return json;
  }

}
