import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:json_serializable_lints/rules/require_json_serializable_to_json.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

@reflectiveTest
class RequireJsonSerializableToJsonTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = RequireJsonSerializableToJson();
    super.setUp();
  }

  void test_missing() async {
    await assertDiagnostics(r'''
class JsonSerializable {
  const JsonSerializable({createToJson = true});
}

@JsonSerializable()
class TestClass {
}
''', [lint(77, 39)]);
  }

  void test_present() async {
    await assertNoDiagnostics(r'''
class JsonSerializable {
  const JsonSerializable({createToJson = true});
}

@JsonSerializable()
class TestClass {
  const TestClass();
  Map<String, dynamic> toJson() => {};
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RequireJsonSerializableToJsonTest);
  });
}
