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

  void test_missing() async {
    await assertDiagnostics(r'''
class JsonSerializable {
  const JsonSerializable({createFactory = true});
}

@JsonSerializable()
class TestClass {
}
''', [lint(78, 39)]);
  }

  void test_present() async {
    await assertNoDiagnostics(r'''
class JsonSerializable {
  const JsonSerializable({createFactory = true});
}

@JsonSerializable()
class TestClass {
  const TestClass();
  factory TestClass.fromJson(Map<String, dynamic> json) => TestClass();
}
''');
  }

  void test_no_annotation() async {
    await assertNoDiagnostics(r'''
class TestClass {
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RequireJsonSerializableFromJsonTest);
  });
}
