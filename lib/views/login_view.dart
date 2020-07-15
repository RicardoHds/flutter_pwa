import 'package:flutter/material.dart';
import 'package:login/constants/route_paths.dart' as routes;
import 'package:login/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: Consumer<LoginViewModel>(
            builder: (context, model, child) => Scaffold(
                  backgroundColor: Colors.grey[200],
                  body: Center(
                    child: SizedBox(
                      width: 400,
                      child: Card(
                        child: Form(
                          onChanged: model.updateFormProgress,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LinearProgressIndicator(value: model.formProgress),
                              Text('Delivery',
                                  style: Theme.of(context).textTheme.headline4),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: model.emailTextController,
                                  decoration:
                                      InputDecoration(hintText: 'Email'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: model.passwordTextController,
                                  decoration:
                                      InputDecoration(hintText: 'Password'),
                                  obscureText: true,
                                ),
                              ),
                              model.isLoading
                                  ? Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator())
                                  : FlatButton(
                                      color: Color.fromARGB(255, 0, 201, 220),
                                      textColor: Colors.white,
                                      onPressed: () async {
                                        if (model.formProgress == 1) {
                                          model.isLoading = true;
                                          if (await model.fetchSignIn(
                                              model.emailTextController.text.trim(),
                                              model.passwordTextController.text.trim(),
                                              context)) {
                                            Navigator.of(context)
                                                .pushNamed(
                                                  routes.HomeRoute,
                                                  arguments: model.getResponseData()
                                                );

                                                
                                          } else {
                                            Scaffold.of(context).showSnackBar(
                                                model.mineSnackBar);
                                          }
                                          model.isLoading = false;
                                        }
                                      },
                                      child: Text('Sign ups'),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )));
  }
}

