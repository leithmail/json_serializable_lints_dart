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
# analysis_options.yaml
plugins:
  json_serializable_lints: any
```

Run analysis:

```sh
dart analyze
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

- [`json_serializable` on pub.dev](https://pub.dev/packages/json_serializable)
- [`analysis_server_plugin` package](https://pub.dev/packages/analysis_server_plugin)

## Contributing

Contributions, issues, and pull requests are welcome.
