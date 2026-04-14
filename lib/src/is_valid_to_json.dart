import 'package:analyzer/dart/element/element.dart';
import 'package:json_serializable_lints/src/normalize_type.dart';

bool isValidToJson(MethodElement method) {
  return method.name == 'toJson' &&
      !method.isStatic &&
      method.formalParameters.isEmpty &&
      normalizeType(method.returnType.getDisplayString()) ==
          'Map<String,dynamic>';
}
