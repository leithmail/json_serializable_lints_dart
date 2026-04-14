# json_serializable_lints

[![Pub Package](https://img.shields.io/pub/v/json_serializable_lints.svg)](https://pub.dev/packages/json_serializable_lints)
[![CI](https://github.com/leithmail/json_serializable_lints_dart/actions/workflows/ci.yml/badge.svg)](https://github.com/leithmail/json_serializable_lints_dart/actions/workflows/ci.yml)
[![codecov](https://codecov.io/github/leithmail/json_serializable_lints_dart/graph/badge.svg?token=BKTXKG5YIG)](https://codecov.io/github/leithmail/json_serializable_lints_dart)

Focused static analysis rules for projects that use `json_serializable`.

`json_serializable` is an excellent library for JSON serialization and deserialization in Dart. However, with current Dart capabilities, each serializable model still needs a small amount of boilerplate — most commonly a `fromJson` factory and a `toJson` method.

Those members are easy to forget when creating or refactoring models. This package helps catch those mistakes early with static analysis, so your `@JsonSerializable()` classes stay consistent and ready for serialization and deserialization.

## What this package checks

- `require_json_serializable_from_json`  
  Requires `factory ClassName.fromJson(json)` on `@JsonSerializable()` classes.
- `require_json_serializable_to_json`  
  Requires `toJson()` on `@JsonSerializable()` classes.
- `require_annotation_from_json`  
  Requires `factory ClassName.fromJson(json)` on classes extending or implementing a class annotated with `@RequireFromJson()`.

If you intentionally disable generation with `createFactory: false` or `createToJson: false`, the corresponding rule is skipped.

## Usage

Install annotations:

```sh
dart pub add json_annotation json_serializable_lints_annotation
```

Add the plugin to your Dart or Flutter project (an analyzer plugin — no need to add it to `pubspec.yaml`):

```yaml
# analysis_options.yaml
plugins:
  json_serializable_lints: any
```

Your IDE will usually run analysis automatically and show warnings inline as you work. You can also run analysis manually:

```sh
dart analyze
```

See the repository examples for ignore patterns and more details.

## More info

- [`json_serializable` on pub.dev](https://pub.dev/packages/json_serializable)
- [`analysis_server_plugin` package](https://pub.dev/packages/analysis_server_plugin)

## Contributing

Contributions, issues, and pull requests are welcome.