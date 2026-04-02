# Examples

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