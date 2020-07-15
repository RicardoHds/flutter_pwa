import 'package:login/helpers/session.dart';
import 'package:login/viewmodels/basemodel.dart';
import 'dart:convert';
import 'dart:async';
import 'package:login/services/home_service.dart';

class HomeViewModel extends BaseModel {
  Future<Customer> fetchCustomer() async {
    final token = await getToken();

    HomeModel _homeServie = HomeModel();
    var response = await _homeServie.getUser(token);

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
