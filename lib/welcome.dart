import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Customer> fetchCustomer(token) async {
  debugPrint(token);
  final response = await http.get(
      'https://mcstaging.vitroautoglass.com/rest/V1/customers/me',
      headers: {'Authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    return Customer.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Customer {
  final String firstname;
  final String email;

  Customer({this.firstname, this.email});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      firstname: json['firstname'],
      email: json['email'],
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final Future<Customer> post;

  final _saved = ['item1', 'item2'];

  WelcomeScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            final listTites = _saved.map((wordPair) {
              return new ListTile(
                title: new Text(wordPair.toUpperCase()),
              );
            });

            return Scaffold(
                appBar: AppBar(
                  title: Text('Menu'),
                ),
                body: Center(child: ListView(children: listTites.toList())));
          }, // ...to here.
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Delivery'),
          actions: [
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: SecondRoute(),
      ),
    );
  }
}

//crea un estado del los widgets
// class MainWidget extends StatefulWidget {
//   @override
//   _MainWidgetState createState() => _MainWidgetState();
// }

// class _MainWidgetState extends State<MainWidget> {
//   @override

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<_MainWidgetModule>();
//   }
// }



//pantalla Home
class WelcomeScreenChild extends StatelessWidget {
  final Future<Customer> post;
  WelcomeScreenChild({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Customer>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      snapshot.data.firstname,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(snapshot.data.email),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

//seguntaPantalla
class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Second Route"),
      // ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Regresa a la primera ruta cuando se pulsa.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
