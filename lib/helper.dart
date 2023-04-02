import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpHelper{
   Future<List> fetchItems() async{
    List<Map> items = [{},{}];
    // Uri url = Uri.parse('http://127.0.0.1:8000/product/');
    // final a = await http.get(url);

    final url = Uri.parse('http://127.0.0.1:8000/product/');
    final a = await http.get(url);
    print(a.statusCode);
    final json = jsonDecode(a.body);
    return json;
  }
}