import 'package:flutter/material.dart';
import 'package:login/helpers/validators.dart';
import 'package:login/shared/button.dart';
import 'package:login/shared/formInput.dart';
import 'package:login/viewmodels/login_viewmodel.dart';
import 'package:login/views/layout/mainLayout.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Language',
      children: SizedBox(
        width: 500,
        child: Card(
          shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
          child: ChangeNotifierProvider(
            create: (context) => LoginViewModel(),
            child: Consumer<LoginViewModel>(
              builder: (context, model, child) => Form(
                key: model.formKey,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                      controller: model.emailController,
                      label: 'Email',
                      validation: Validators().emailValidator,
                      autoFocus: true,
                    ),
                    FormInput(
                      controller: model.passwordController,
                      label: 'Password',
                      validation: Validators().requiredValidator,
                      isPassword: true,
                    ),
                    Button(
                        label: 'Sign up',
                        indicator: model.isLoading,
                        onPress: () {
                          model.login(context);
                        }),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
