import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:json_serializable_lints/rules/require_from_json_annotation_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

class TestClass {}

@reflectiveTest
class RequireFromJsonAnnotationRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = RequireFromJsonAnnotationRule();
    super.setUp();
  }

  void test_annotatedClass_withFromJson_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
class TestClass {
  factory TestClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}
''');
  }

  void test_annotatedClass_missingFromJson_lint() async {
    await assertDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
class TestClass {
}
''', [lint(54, 38)]);
  }

  void test_abstractClass_withAnnotation_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}
''');
  }

  void test_abstractClass_withFromJson_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {
  factory BaseClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}
''');
  }

  void test_extends_withFromJson_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}

class ChildClass extends BaseClass {
  factory ChildClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}
''');
  }

  void test_extends_missingFromJson_lint() async {
    await assertDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}

class ChildClass extends BaseClass {}
''', [lint(102, 37)]);
  }

  void test_extends_grandchild_missingFromJson_lint() async {
    await assertDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}

class ChildClass extends BaseClass {
  ChildClass();
  factory ChildClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}

class GrandChildClass extends ChildClass {}
''', [lint(241, 43)]);
  }

  void test_extends_grandchild_withFromJson_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}

class ChildClass extends BaseClass {
  factory ChildClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}

class GrandChildClass extends ChildClass {
  factory GrandChildClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}
''');
  }

  void test_implements_withFromJson_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}

class ChildClass implements BaseClass {
  factory ChildClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}
''');
  }

  void test_implements_missingFromJson_lint() async {
    await assertDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}

class ChildClass implements BaseClass {}
''', [lint(102, 40)]);
  }

  void test_mixin_withFromJson_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}

class ChildClass with SomeMixin implements BaseClass {
  factory ChildClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}

mixin SomeMixin {}
''');
  }

  void test_mixin_missingFromJson_lint() async {
    await assertDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
abstract class BaseClass {}

class ChildClass with SomeMixin implements BaseClass {}

mixin SomeMixin {}
''', [lint(102, 55)]);
  }

  void test_fromJson_nonMapParameter_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
class TestClass {
  factory TestClass.fromJson(int value) => throw "unimplemented";
}
''');
  }

  void test_fromJson_dynamicParameter_noLint() async {
    await assertNoDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
class TestClass {
  factory TestClass.fromJson(dynamic json) => throw "unimplemented";
}
''');
  }

  void test_fromJson_notFactory_lint() async {
    await assertDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
class TestClass {
  TestClass.fromJson(Map<String, dynamic> json);
}
''', [lint(54, 87)]);
  }

  void test_fromJson_noParameters_lint() async {
    await assertDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
class TestClass {
  factory TestClass.fromJson() => throw "unimplemented";
}
''', [lint(54, 95)]);
  }

  void test_fromJson_staticMethod_lint() async {
    await assertDiagnostics(r'''
class RequireFromJson {
  const RequireFromJson();
}

@RequireFromJson()
class TestClass {
  static TestClass fromJson(Map<String, dynamic> json) => throw "unimplemented";
}
''', [lint(54, 119)]);
  }

  void test_noAnnotation_noLint() async {
    await assertNoDiagnostics(r'''
class TestClass {}
''');
  }

  void test_noAnnotation_withFromJson_noLint() async {
    await assertNoDiagnostics(r'''
class TestClass {
  factory TestClass.fromJson(Map<String, dynamic> json) => throw "unimplemented";
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RequireFromJsonAnnotationRuleTest);
  });
}
