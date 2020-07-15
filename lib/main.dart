import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Menu'),
            ),
            body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(Icons.center_focus_weak,
                        color: Colors.black, size: 50.0, semanticLabel: 'Text'),
                    Text('Scan QR', textAlign: TextAlign.center)
                  ],
                ),
              ),
            ]),
          );
        }),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('Delivery'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SizedBox(
            width: 500,
            child: Card(
                shadowColor: Color.fromRGBO(0, 0, 0, 0.2), child: SignUpForm()),
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
      backgroundColor: Colors.red[300]);
  final _formKey = GlobalKey<FormState>();
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Required field'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        errorText: 'Invalid email')
  ]);

  bool _isLoading = false;

  String requiredField(String value) {
    if (value.isEmpty) {
      return 'Required field';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Image.asset(
              'assets/images/logo-vitro.png',
              fit: BoxFit.cover,
              scale: 4.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              controller: _emailTextController,
              decoration: InputDecoration(
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[400])),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[400])),
              ),
              autofocus: true,
              validator: emailValidator,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              controller: _passwordTextController,
              decoration: InputDecoration(
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[400])),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[400])),
              ),
              obscureText: true,
              validator: requiredField,
            ),
          ),
          _isLoading
              ? Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator())
              : ButtonTheme(
                  minWidth: 250.0,
                  height: 50.0,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Color.fromRGBO(0, 201, 220, 1),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => _isLoading = true);
                          if (await fetchSignIn(_emailTextController.text,
                              _passwordTextController.text, context)) {
                          } else {
                            Scaffold.of(context).showSnackBar(mineSnackBar);
                          }
                          setState(() => _isLoading = false);
                        }
                      },
                      child: Text('Sign up')),
                ),
        ]),
      ),
    );
  }
}

Future<bool> fetchSignIn(
    String username, String password, BuildContext context) async {
  final _url =
      'https://mcstaging.vitroautoglass.com/rest/V1/integration/customer/token';

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
