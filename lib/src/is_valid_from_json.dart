import 'package:analyzer/dart/element/element.dart';
import 'package:json_serializable_lints/src/normalize_type.dart';

bool isValidFromJson(ConstructorElement constructor) {
  if (!constructor.isFactory || constructor.name != 'fromJson') {
    return false;
  }

  final parameters = constructor.formalParameters;
  if (parameters.length != 1) {
    return false;
  }

  final parameter = parameters.single;
  final type = normalizeType(parameter.type.getDisplayString());

  return type == 'Map<String,dynamic>';
}
