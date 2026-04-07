import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

class AddToJsonFix extends ResolvedCorrectionProducer {
  static const _kind = FixKind(
    'dart.fix.json_serializable.add_to_json',
    DartFixKindPriority.standard,
    "Add usual @JsonSerializable `toJson` method implementation",
  );

  AddToJsonFix({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => _kind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    builder.addDartFileEdit(file, (builder) {
      final node = this.node;
      if (node is! ClassDeclaration) return; // coverage:ignore-line

      final className = node.namePart;
      final toJsonMethod = '''
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);
''';
      builder.addInsertion(node.end - 1, (editBuilder) {
        editBuilder.write(toJsonMethod);
      });
    });
  }
}
