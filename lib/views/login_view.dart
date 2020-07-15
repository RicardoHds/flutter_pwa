import 'package:flutter/material.dart';
import 'package:login/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:login/constants/route_paths.dart' as routes;

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
                          Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                              controller: model.emailTextController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[400])),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[400])),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red[400])),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red[400])),
                              ),
                              autofocus: true,
                              validator: model.emailValidator,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                                controller: model.passwordTextController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[400])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[400])),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red[400])),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red[400])),
                                ),
                                obscureText: true,
                                validator: model.requiredField),
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
                                                  .trim(),
                                              context)) {
                                            Navigator.of(context).pushNamed(
                                                routes.HomeRoute,
                                                arguments:
                                                    model.getResponseData());
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
