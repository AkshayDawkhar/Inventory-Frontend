import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  Future<List> fetchItems() async {
    List<Map> items = [{}, {}];
    // Uri url = Uri.parse('http://127.0.0.1:8000/product/');
    // final a = await http.get(url);

    final url = Uri.parse('http://127.0.0.1:8000/product/');
    // await Future.delayed(Duration(seconds: 1));
    final a = await http.get(url);
    print(a.statusCode);
    final json = jsonDecode(a.body);
    return json;
  }

  Future fetchItem(String pid) async {
    await Future.delayed(Duration(seconds: 4));
    final url = Uri.parse('http://127.0.0.1:8000/build/edit/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future fetchItemName(String pid) async {
    await Future.delayed(Duration(seconds: 5));
    final url = Uri.parse('http://127.0.0.1:8000/product/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future createItem(String name, String category, String color,
      List requiredItems, List requiredItemsNo) async {
    final url = Uri.parse('http://127.0.0.1:8000/product/');
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
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/build/required/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future fetchItem1(String pid) async {
    await Future.delayed(Duration(seconds: 4));
    final url = Uri.parse('http://127.0.0.1:8000/product/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('______________-----_____________');
    print(json);
    return json;
  }

  Future<List> fetchNeeded(String pid) async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/build/needed/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future<int> fetchMax(String pid) async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/build/$pid');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print(json);
    return json;
  }

  Future<int> deleteproduct(String pid) async {
    await Future.delayed(Duration(seconds: 6));
    final url = Uri.parse('http://127.0.0.1:8000/product/$pid');
    final a = await http.delete(url);
    final json = jsonDecode(a.body);
    print('------------> ${a.statusCode}');
    return a.statusCode;
  }

  Future<List> fetchTrashProduct() async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/product/trash/');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('trash product -----------> $json');
    return json;
  }

  Future<int> deleteTrash(String pid) async {
    await Future.delayed(Duration(seconds: 6));
    final url = Uri.parse('http://127.0.0.1:8000/product/trash/$pid');
    final a = await http.delete(url);
    final json = jsonDecode(a.body);
    print('------------> ${a.statusCode}-->${a.body}');
    return a.statusCode;
  }

  Future<int> restoreTrash(String pid) async {
    await Future.delayed(Duration(seconds: 6));
    final url = Uri.parse('http://127.0.0.1:8000/product/trash/$pid');
    final a = await http.post(url);
    final json = jsonDecode(a.body);
    print('------------> ${a.statusCode}-->${a.body}');
    return a.statusCode;
  }

  Future<List> fetchAccount() async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/account/');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('account -----------> $json');
    return json;
  }

  Future<List> fetchAdmin() async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/account/admin/');
    final a = await http.get(url);
    final json = jsonDecode(a.body);
    print('admin -----------> $json');
    return json;
  }

  Future<http.Response> createAdmin(String f_name,String l_name, String username,String password,String mail) async {
    // String f_name = 'akshayqwqw';
    // String l_name = 'dawkharqwqw';
    // String username = 'akshaydawkhar2qwqw';
    // String password = 'akshaydawkhar2qwqw';
    // String mail = 'akshay@gmail.comcom';
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('http://127.0.0.1:8000/account/admin/');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "f_name": f_name,
          "l_name": l_name,
          "username": username,
          "password": password,
          "mail": mail
        }));
    print('creating admin ${responce.body}');
    return responce;
  }
  Future<int> deleteAdmin(String username) async {
    await Future.delayed(Duration(seconds: 2));
    final url = Uri.parse('http://127.0.0.1:8000/account/admin/$username');
    final a = await http.delete(url);
    final json = jsonDecode(a.body);
    print('-----------+++===-> ${a.statusCode}-->${a.body}');
    return a.statusCode;
  }


  Future<int> deleteWorker(String username) async {
    await Future.delayed(Duration(seconds: 2));
    final url = Uri.parse('http://127.0.0.1:8000/account/$username');
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
}
