import 'package:form_validator/form_validator.dart';

final emailValidator = ValidationBuilder()
    .email('Inavlid Email')
    .maxLength(50, 'Max Length 50 chars')
    .build();
final passwordValidator = ValidationBuilder()
    .minLength(6, 'Min Length 6 chars')
    .maxLength(50)
    .build();
