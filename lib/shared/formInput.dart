import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final MultiValidator validation;
  final bool autoFocus;
  final bool isPassword;

  FormInput({
    @required this.controller,
    @required this.label,
    @required this.validation,
    this.autoFocus = false,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[400])),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[400])),
        ),
        autofocus: autoFocus,
        obscureText: isPassword,
        validator: validation,
      ),
    );
  }
}
