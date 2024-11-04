import 'model_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model_configuration_notifier.g.dart';

@riverpod
class ModelConfigurationNotifier extends _$ModelConfigurationNotifier {
  @override
  ModelConfiguration build() {
    loadConfiguration();
    return const ModelConfiguration();
  }

  String _getPreference(
      SharedPreferences prefs, String key, String defaultValue) {
    return prefs.getString(key) ?? defaultValue;
  }

  Future<void> loadConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    final scale = _getPreference(prefs, 'scaleOnInfinitePrecision', '16');
    state = ModelConfiguration(scaleOnInfinitePrecision: scale);
  }

  Future<void> saveConfiguration(ModelConfiguration config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'scaleOnInfinitePrecision', config.scaleOnInfinitePrecision);
    state = config;
  }

  void updateScaleOnInfinitePrecision(String value) {
    state = state.copyWith(scaleOnInfinitePrecision: value);
  }
}
