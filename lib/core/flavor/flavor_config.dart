import 'flavor.dart';
import 'flavor_values.dart';

class FlavorConfig {
  FlavorConfig._(this._flavor, this._values);

  Flavor _flavor;
  FlavorValues _values;

  static FlavorConfig? _instance;

  factory FlavorConfig(
          {required Flavor flavor, required FlavorValues values}) =>
      _instance ??= FlavorConfig._(flavor, values);

  static Flavor get flavor => _instance!._flavor;
  static FlavorValues get values => _instance!._values;
}
