import 'package:analyzer/dart/element/element.dart';

bool isValidToJson(MethodElement method) {
  return method.name == 'toJson' &&
      !method.isStatic &&
      method.formalParameters.isEmpty;
}
