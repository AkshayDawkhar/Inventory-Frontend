import 'package:flutter/material.dart';
import 'package:inventory/routes.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            margin: width <= 600 ? EdgeInsets.all(12) : EdgeInsets.all(90),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurRadius: 1000.0,
                ),
              ],
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('WELCOME ${_usernameController.text}',style: TextStyle(fontSize: 30),),
                SizedBox(
                  height: 148.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,

                        validator: (value){
                          if(_usernameController.value != 'akshay987'){
                            return 'Please enter valid username';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',

                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      GoRouter.of(context).go('/');
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.greenAccent,
                        )),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.login), Text('     Login')],
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
