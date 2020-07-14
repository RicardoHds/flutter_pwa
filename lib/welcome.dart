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
  final _saved = [
    {"title": "Profile"},
    {"title": "Log out"}
  ];

  // final Map<String, dynamic> _saved = jsonDecode({
  //   {"title": "Profile"},
  //   {"title": "Log out"}
  // });
  WelcomeScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            // final tiles = _saved.map(
            //   (pair) {
            //     return ListTile(
            //       title: Text(
            //         pair,
            //       ),
            //     );
            //   },
            // );

            // final divided = ListTile.divideTiles(
            //   context: context,
            //   tiles: tiles,
            // ).toList();

            return Scaffold(
                appBar: AppBar(
                  title: Text('Menu'),
                ),
                // body: ListView(children: divided),
                body: ListView.builder(
                    itemCount: _saved.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${_saved[index]}'),
                      );
                    }));
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
        body: WelcomeScreenChild(post: post),
      ),
    );
  }
}

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
