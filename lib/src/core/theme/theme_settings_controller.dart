import 'package:emanart/src/core/constants/emanart_sizes.dart';
import 'package:emanart/src/core/theme/theme_settings_model.dart';
import 'package:hive/hive.dart';

class ThemeSettingsController {
  static late ThemeSettingsController _instance;
  static bool _wasInitialized = false;
  final themeSettingsStorage = Hive.box<ThemeSettingsModel>("theme_settings");

  ThemeSettingsController._();

  static ThemeSettingsController instance() {
    if (!_wasInitialized) {
      _instance = ThemeSettingsController._();
      _wasInitialized = true;
    }

    _instance.initStorage();
    return _instance;
  }

  // Initialize the persistent local storage
  void initStorage() {
    if (themeSettingsStorage.values.isEmpty) {
      ThemeSettingsModel themeSettingsModel = const ThemeSettingsModel(
        darkMode: false,
        uiScale: EmanArtSizes.kDefaultUiScale,
        primaryTextSize: EmanArtSizes.kDefaultPrimaryTextSize,
      );
      themeSettingsStorage.add(themeSettingsModel);
    }
  }

  void updateThemeSettings(
    bool darkMode,
    double uiScale,
    double primaryTextSize,
  ) {
    themeSettingsStorage.putAt(
      0,
      themeSettingsStorage.values.first.copyWith(
        darkMode: darkMode,
        uiScale: uiScale,
        primaryTextSize: primaryTextSize,
      ),
    );
  }

  ThemeSettingsModel getThemeSettings() {
    return themeSettingsStorage.values.first;
  }
}
