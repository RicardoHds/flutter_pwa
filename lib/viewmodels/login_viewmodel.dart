import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/viewmodels/basemodel.dart';
import 'package:login/constants/urls.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginViewModel extends BaseModel {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final mineSnackBar = SnackBar(
    content: Text('The account sign-in was incorrect.'),
    backgroundColor: Colors.red[300],
  );

  double formProgress = 0;
  bool isLoading = false;

  void updateFormProgress() {
    var progress = 0.0;
    var controllers = [
      emailTextController,
      passwordTextController,
    ];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    formProgress = progress;
  }

  String getResponseData() {
    return responseString.replaceAll('"', ' ').trim();
  }

  var responseString;
  Future<bool> fetchSignIn(String username, String password, context) async {
    setBusy(true);

    var _url = api + 'integration/customer/token';
    var body = {"username": username, "password": password};
    print(body);

    final http.Response response = await http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    var success = false;
    if (response.statusCode == 200) {
      responseString = response.body;

      success = true;
    }

    if (!success) {
      setErrorMessage('Error has occured with the login');
    } else {
      setErrorMessage(null);
    }

    setBusy(false);
    return success;
  }

  final formKey = GlobalKey<FormState>();
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Required field'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        errorText: 'Invalid email')
  ]);

  String requiredField(String value) {
    if (value.isEmpty) {
      return 'Required field';
    }
    return null;
  }
}
