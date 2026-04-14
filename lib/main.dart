import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:json_serializable_lints/rules/require_from_json_annotation_rule.dart';
import 'package:json_serializable_lints/rules/require_from_json_rule.dart';
import 'package:json_serializable_lints/rules/require_to_json_rule.dart';

final plugin = JsonSerializableLints();

class JsonSerializableLints extends Plugin {
  @override
  String get name => 'json_serializable_lints';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(RequireToJsonRule());
    registry.registerWarningRule(RequireFromJsonRule());
    registry.registerWarningRule(RequireFromJsonAnnotationRule());
  }
}
