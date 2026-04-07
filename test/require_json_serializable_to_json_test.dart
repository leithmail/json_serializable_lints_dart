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

  void test_ok() async {
    await assertNoDiagnostics(r'''
void f(Future<int> p) async {
  // No await.
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RequireJsonSerializableToJsonTest);
  });
}
