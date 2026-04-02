import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:json_serializable_lints/rules/require_json_serializable_from_json.dart';
import 'package:json_serializable_lints/rules/require_json_serializable_to_json.dart';

final plugin = JsonSerializableLints();

class JsonSerializableLints extends Plugin {
  @override
  String get name => 'json_serializable_lints';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(RequireJsonSerializableToJson());
    registry.registerWarningRule(RequireJsonSerializableFromJson());
  }
}
