import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Required field'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        errorText: 'Invalid email')
  ]);

  final requiredValidator = MultiValidator([
    RequiredValidator(errorText: 'Required field'),
  ]);
}
