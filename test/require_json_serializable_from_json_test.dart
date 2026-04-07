import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:json_serializable_lints/rules/require_json_serializable_from_json.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

@reflectiveTest
class RequireJsonSerializableFromJsonTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = RequireJsonSerializableFromJson();
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
    defineReflectiveTests(RequireJsonSerializableFromJsonTest);
  });
}
