import 'package:flutter/material.dart';
import 'package:login/helpers/validators.dart';
import 'package:login/shared/formInput.dart';
import 'package:login/viewmodels/login_viewmodel.dart';
import 'package:login/views/home_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Menu'),
            ),
            body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(Icons.center_focus_weak,
                        color: Colors.black, size: 50.0, semanticLabel: 'Text'),
                    Text('Scan QR', textAlign: TextAlign.center)
                  ],
                ),
              ),
            ]),
          );
        }),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
          // resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.blueGrey[100],
          appBar: AppBar(
            title: Text('Deliverys'),
            actions: [
              IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
            ],
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 500,
                  child: Card(
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
                    child: Form(
                      key: model.formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          model.hashErrorMessage
                              ? Text(
                                  model.errorMessage,
                                  style: TextStyle(
                                      color: Colors.red[800],
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                )
                              : Column(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Image.asset(
                              'assets/images/logo-vitro.png',
                              fit: BoxFit.cover,
                              scale: 4.0,
                            ),
                          ),
                          FormInput(
                            controller: model.emailTextController,
                            label: 'Email',
                            validation: Validators().emailValidator,
                            autoFocus: true,
                          ),
                          FormInput(
                            controller: model.passwordTextController,
                            label: 'Password',
                            validation: Validators().requiredValidator,
                            isPassword: true,
                          ),
                          model.isLoading
                              ? Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator())
                              : ButtonTheme(
                                  minWidth: 250.0,
                                  height: 50.0,
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      color: Color.fromRGBO(0, 201, 220, 1),
                                      textColor: Colors.white,
                                      onPressed: () async {
                                        if (model.formKey.currentState
                                            .validate()) {
                                          model.isLoading = true;
                                          if (await model.fetchSignIn(
                                              model.emailTextController.text
                                                  .trim(),
                                              model.passwordTextController.text
                                                  .trim())) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeView()));
                                          }
                                          model.isLoading = false;
                                        }
                                      },
                                      child: Text('Sign up')),
                                ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
