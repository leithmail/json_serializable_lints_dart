import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:json_serializable_lints/src/is_valid_from_json.dart';

class RequireFromJsonRule extends AnalysisRule {
  static const LintCode code = LintCode(
    'require_json_serializable_from_json',
    '@JsonSerializable classes must declare `factory ClassName.fromJson(json)`',
    severity: DiagnosticSeverity.WARNING,
  );

  RequireFromJsonRule()
      : super(
          name: 'require_json_serializable_from_json',
          description:
              '@JsonSerializable classes must declare `factory ClassName.fromJson(json)`',
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
    if (!_hasJsonSerializableAnnotation(node)) {
      return;
    }
    final element = node.declaredFragment?.element;
    if (element == null) return; // coverage:ignore-line

    final hasValidFromJson = element.constructors.any(isValidFromJson);

    if (!hasValidFromJson) {
      rule.reportAtNode(node);
    }
  }

  static bool _hasJsonSerializableAnnotation(ClassDeclaration node) {
    final matches = node.metadata.whereType<Annotation>();
    final annotation = matches.any((a) => a.name.name == 'JsonSerializable')
        ? matches.firstWhere((a) => a.name.name == 'JsonSerializable')
        : null;
    if (annotation == null) {
      return false;
    }

    final args = annotation.arguments?.arguments ?? const <Argument>[];
    final hasCreateFactoryFalse = args.any(
      (arg) =>
          arg is NamedArgument &&
          arg.name.lexeme == 'createFactory' &&
          arg.argumentExpression is BooleanLiteral &&
          (arg.argumentExpression as BooleanLiteral).value == false,
    );
    return !hasCreateFactoryFalse;
  }
}
