import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/viewmodels/basemodel.dart';
import 'package:login/services/login_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseModel {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final mineSnackBar = SnackBar(
    content: Text('The account sign-in was incorrect.'),
    backgroundColor: Colors.red[300],
  );
  final formKey = GlobalKey<FormState>();
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Required field'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        errorText: 'Invalid email')
  ]);

  final requiredValidator = MultiValidator([
    RequiredValidator(errorText: 'Required field'),
  ]);

  bool isLoading = false;
  String getResponseData() {
    return responseString.replaceAll('"', ' ').trim();
  }

  LoginService _loginService = LoginService();

  String responseString;
  Future<bool> fetchSignIn(String username, String password, context) async {
    setBusy(true);

    var body = {"username": username, "password": password};

    var response = await _loginService.signIn(body);

    var success = false;
    if (response.statusCode == 200) {
      responseString = response.body;
      success = true;
      var token = responseString.replaceAll('"', ' ').trim();
      _saveToken(token);
    }

    if (!success) {
      setErrorMessage('Error has occured with the login');
    } else {
      setErrorMessage(null);
    }

    setBusy(false);
    return success;
  }

  _saveToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
