# json_serializable_lints

Small analysis server plugin with focused lints for `json_serializable` models.

## Rules

- `require_json_serializable_from_json`  
  Requires `factory ClassName.fromJson(Map<String, dynamic> json)` on `@JsonSerializable()` classes.
- `require_json_serializable_to_json`  
  Requires `Map<String, dynamic> toJson()` on `@JsonSerializable()` classes.

These rules are skipped when you explicitly disable generation with `createFactory: false` or `createToJson: false`.

## Usage

Add the package to your Dart or Flutter project:

```yaml
# pubspec.yaml
dev_dependencies:
  json_serializable_lints:
```

Enable the plugin:

```yaml
# analysis_options.yaml
analyzer:
  plugins:
    - json_serializable_lints
```

Minimal example:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;

  User(this.name);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

## Ignoring rules

Ignore a single violation:

```dart
// ignore: require_json_serializable_to_json
@JsonSerializable()
class LegacyUser {
  LegacyUser();

  factory LegacyUser.fromJson(Map<String, dynamic> json) => LegacyUser();
}
```

Ignore for a whole file:

```dart
// ignore_for_file: require_json_serializable_from_json, require_json_serializable_to_json
```

## More info

- [`analysis_server_plugin` package](https://pub.dev/packages/analysis_server_plugin)
- [Dart analyzer plugin docs / examples](https://github.com/dart-lang/sdk/tree/main/pkg/analyzer_plugin)

## Contributing

Contributions, issues, and pull requests are welcome.
