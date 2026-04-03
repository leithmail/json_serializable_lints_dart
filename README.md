# json_serializable_lints

Focused static analysis rules for projects that use `json_serializable`.

`json_serializable` is an excellent library for JSON serialization and deserialization in Dart. However, with current Dart capabilities, each serializable model still needs a small amount of boilerplate — most commonly a `fromJson` factory and a `toJson` method.

Those members are easy to forget when creating or refactoring models. This package helps catch those mistakes early with static analysis, so your `@JsonSerializable()` classes stay consistent and ready for code generation.

## What this package checks

- `require_json_serializable_from_json`  
  Requires `factory ClassName.fromJson(Map<String, dynamic> json)` on `@JsonSerializable()` classes.
- `require_json_serializable_to_json`  
  Requires `Map<String, dynamic> toJson()` on `@JsonSerializable()` classes.

If you intentionally disable generation with `createFactory: false` or `createToJson: false`, the corresponding rule is skipped.

## Usage

Add the plugin to your Dart or Flutter project:

```yaml
# analysis_options.yaml
plugins:
  json_serializable_lints: any
```

Your IDE will usually run analysis automatically and show these warnings inline as you work. You can also run analysis manually:

```sh
dart analyze
```

See the repository examples for ignore patterns and more details.

## More info

- [`json_serializable` on pub.dev](https://pub.dev/packages/json_serializable)
- [`analysis_server_plugin` package](https://pub.dev/packages/analysis_server_plugin)

## Contributing

Contributions, issues, and pull requests are welcome.
