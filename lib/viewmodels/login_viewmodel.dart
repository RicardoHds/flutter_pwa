import 'package:flutter/material.dart';
import 'package:login/helpers/session.dart';
import 'package:login/viewmodels/basemodel.dart';
import 'package:login/services/login_service.dart';
import 'package:login/views/home_view.dart';

class LoginViewModel extends BaseModel {
  LoginService _loginService = LoginService();
  HelpersSession _helpersSession = HelpersSession();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  login(context) async {
    if (formKey.currentState.validate()) {
      isLoading = true;
      if (await fetchSignIn()) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      }
      isLoading = false;
    }
  }

  Future<bool> fetchSignIn() async {
    setBusy(true);
    var body = {
      "username": emailController.text,
      "password": passwordController.text
    };
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
