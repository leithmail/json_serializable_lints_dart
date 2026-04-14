import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:json_serializable_lints/src/is_valid_from_json.dart';

class RequireFromJsonAnnotationRule extends AnalysisRule {
  static const LintCode code = LintCode(
    'require_annotation_from_json',
    'Missing `factory ClassName.fromJson(json)` required by @RequireFromJson on base class',
    severity: DiagnosticSeverity.WARNING,
  );

  RequireFromJsonAnnotationRule()
      : super(
          name: 'require_annotation_from_json',
          description:
              'Missing `factory ClassName.fromJson(json)` required by @RequireFromJson on base class',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _Visitor(this, context);
    registry.addClassDeclaration(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final AnalysisRule rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final element = node.declaredFragment?.element;
    if (element == null) return; // coverage:ignore-line

    // Skip abstract classes and the annotated class itself
    if (element.isAbstract) {
      return;
    }

    // Check if the class itself or any supertype has @RequireFromJson
    final requiresFromJson = _hasRequireFromJsonAnnotation(element) ||
        element.allSupertypes
            .any((t) => _hasRequireFromJsonAnnotation(t.element));

    if (!requiresFromJson) {
      return;
    }

    final hasValidFromJson = element.constructors.any(isValidFromJson);
    if (!hasValidFromJson) {
      rule.reportAtNode(node);
    }
  }

  static bool _hasRequireFromJsonAnnotation(Element element) {
    return element.metadata.annotations.any(
      (a) => a.element?.enclosingElement?.name == 'RequireFromJson',
    );
  }
}
