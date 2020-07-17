import 'package:flutter/material.dart';
import 'package:login/helpers/session.dart';
import 'package:login/shared/confirmDialog.dart';
import 'package:login/viewmodels/home_viewmodel.dart';
import 'package:login/views/layout/mainLayout.dart';
import 'package:login/views/login/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = HomeViewModel();

    return MainLayout(
      children: Center(
        child: FutureBuilder<Customer>(
            future: model.fetchCustomer(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
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
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ConfirmDialog(
                      title: 'Log out',
                      content:
                          'Are you sure? Logging out will remove your session from this device.',
                      button: 'Log out',
                      onPress: () {
                        HelpersSession().logOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()));
                      },
                    ),
                  ),
                ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
