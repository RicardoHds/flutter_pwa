import 'package:login/viewmodels/basemodel.dart';
import 'dart:convert';
import 'dart:async';
import 'package:login/services/home_service.dart';

class HomeViewModel extends BaseModel {
  Future<Customer> fetchCustomer() async {
    HomeModel _homeServie = HomeModel();
    var response = await _homeServie.getUser();

    if (response.statusCode == 200) {
      return Customer.fromJson(response.data);
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

  factory Customer.fromJson(Map<dynamic, dynamic> json) {
    return Customer(
      firstname: json['firstname'],
      email: json['email'],
    );
  }
}
