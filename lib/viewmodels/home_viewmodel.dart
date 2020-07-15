import 'package:http/http.dart' as http;
import 'package:login/viewmodels/basemodel.dart';
import 'package:login/constants/urls.dart';
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

var _url = api + 'customers/me';

class HomeViewModel extends BaseModel {
  Future<Customer> fetchCustomer() async {
    String token;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';

    final response =
        await http.get(_url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return Customer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<bool> logout({bool success = true}) async {
    setBusy(true);
    await Future.delayed(Duration(seconds: 1));

    if (!success) {
      setErrorMessage('Error has occurred during sign out');
    } else {
      setErrorMessage(null);
    }

    setBusy(false);
    return success;
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
