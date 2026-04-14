import 'package:analyzer/dart/element/element.dart';

bool isValidFromJson(ConstructorElement constructor) {
  if (!constructor.isFactory || constructor.name != 'fromJson') {
    return false;
  }

  final parameters = constructor.formalParameters;
  return parameters.length == 1 && parameters.single.isRequired;
}
