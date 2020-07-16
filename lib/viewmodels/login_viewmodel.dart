import 'package:flutter/material.dart';
import 'package:login/helpers/session.dart';
import 'package:login/viewmodels/basemodel.dart';
import 'package:login/services/login_service.dart';

class LoginViewModel extends BaseModel {
  LoginService _loginService = LoginService();
  HelpersSession _helpersSession = HelpersSession();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<bool> fetchSignIn(String username, String password) async {
    setBusy(true);
    var body = {"username": username, "password": password};
    var response = await _loginService.signIn(body);
    var success = false;

    if (response.statusCode == 200) {
      var responseString = response.body;
      success = true;
      var token = responseString.replaceAll('"', ' ').trim();
      _helpersSession.saveToken(token);
    }

    if (!success) {
      setErrorMessage('Error has occured with the login');
    } else {
      setErrorMessage(null);
    }

    setBusy(false);
    return success;
  }
}
