import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:login/helpers/session.dart';
import 'package:login/shared/confirmDialog.dart';
import 'package:login/viewmodels/home_viewmodel.dart';
import 'package:login/views/layout/mainDrawer.dart';
import 'package:login/views/login_view.dart';
import 'package:provider/provider.dart';
import '../helpers/translations.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return I18n(
      child: ChangeNotifierProvider(
        create: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(
          builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.blueGrey[100],
            appBar: AppBar(title: Text("Language".i18n)),
            drawer: MainDrawer(),
            body: Center(
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
          ),
        ),
      ),
    );
  }
}
