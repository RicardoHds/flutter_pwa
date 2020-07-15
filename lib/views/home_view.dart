import 'package:flutter/material.dart';
import 'package:login/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:login/constants/urls.dart';
// import 'dart:convert';
import 'dart:async';


class HomeView extends StatelessWidget {
  final String data;
  const HomeView(this.data, {Key key, this.post}) : super(key: key);

  final Future<Customer> post;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(
            builder: (context, model, child) => Scaffold(
                  body: Center(
                    child: FutureBuilder<Customer>(
                      future: model.fetchCustomer(data),
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
                )));
  }
}