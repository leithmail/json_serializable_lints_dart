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

  void test_present_invalid_signature_1() async {
    await assertDiagnostics(r'''
class JsonSerializable {
  const JsonSerializable({createToJson = true});
}

@JsonSerializable()
class TestClass {
  const TestClass();
  int toJson() => 0;
}
''', [lint(77, 81)]);
  }

  void test_present_invalid_signature_2() async {
    await assertDiagnostics(r'''
class JsonSerializable {
  const JsonSerializable({createToJson = true});
}

@JsonSerializable()
class TestClass {
  const TestClass();
  Map<String, dynamic> toJson(int nonsense) => {};
}
''', [lint(77, 111)]);
  }

  void test_no_annotation() async {
    await assertNoDiagnostics(r'''
class TestClass {
}
''');
  }

  void test_disabled() async {
    await assertNoDiagnostics(r'''
class JsonSerializable {
  const JsonSerializable({createToJson = true});
}

@JsonSerializable(createToJson: false)
class TestClass {
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RequireJsonSerializableToJsonTest);
  });
}
