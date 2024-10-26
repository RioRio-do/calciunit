import 'package:shared_preferences/shared_preferences.dart';
import 'package:calciunit/sav/model_configuration.dart';

Future<void> saveConfiguration(ModelConfiguration config) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'scaleOnInfinitePrecision', config.scaleOnInfinitePrecision);
}

Future<ModelConfiguration> loadConfiguration() async {
  final prefs = await SharedPreferences.getInstance();
  final scaleOnInfinitePrecision =
      prefs.getString('scaleOnInfinitePrecision') ?? '16';
  return ModelConfiguration(scaleOnInfinitePrecision: scaleOnInfinitePrecision);
}
