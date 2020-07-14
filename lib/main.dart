import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/welcome.dart';

void main() => runApp(SignUpApp());

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SignUpScreen(),
        '/welcome': (context) => WelcomeScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final mineSnackBar = SnackBar(
    content: Text('The account sign-in was incorrect.'),
    backgroundColor: Colors.red[300],
  );

  double _formProgress = 0;
  bool _isLoading = false;

  void _updateFormProgress() {
    var progress = 0.0;
    var controllers = [
      _emailTextController,
      _passwordTextController,
    ];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          Text('Delivery', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailTextController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordTextController,
              decoration: InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
          ),
          _isLoading
              ? Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator())
              : FlatButton(
                  color: Color.fromARGB(255, 0, 201, 220),
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formProgress == 1) {
                      setState(() => _isLoading = true);
                      if (await fetchSignIn(_emailTextController.text,
                          _passwordTextController.text, context)) {
                      } else {
                        Scaffold.of(context).showSnackBar(mineSnackBar);
                      }
                      setState(() => _isLoading = false);
                    }
                  },
                  child: Text('Sign ups'),
                ),
        ],
      ),
    );
  }
}

Future<bool> fetchSignIn(
    String username, String password, BuildContext context) async {
  final _url = 'https://google.com';

  final body = {"username": username, "password": password};
  debugPrint(jsonEncode(body));
  final http.Response response = await http.post(_url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    final responseString = response.body;

    // Navigator.of(context).pushNamed('/welcome');
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new WelcomeScreen(
        post: fetchCustomer(responseString.replaceAll('"', ' ').trim()),
      );
    }));
    return true;
  } else {
    return false;
  }
}
