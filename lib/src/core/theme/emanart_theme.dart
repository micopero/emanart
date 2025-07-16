import 'package:emanart/src/core/constants/emanart_colors.dart';
import 'package:emanart/src/core/constants/emanart_sizes.dart';
import 'package:emanart/src/core/theme/theme_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// class to contain the properties
class EmanArtThemeState {
  bool darkMode;
  double uiScale;
  double primaryTextSize;

  // theme colors
  Color primaryBackgroundColor;
  Color secondaryBackgroundColor;
  Color activeItemColor;
  Color inActiveItemColor;
  Color textColor;
  Color textFieldBorderColor;
  Color textFieldErrorBorderColor;
  Color minValueColor;
  Color maxValueColor;

  EmanArtThemeState({
    this.darkMode = false,
    this.uiScale = EmanArtSizes.kDefaultUiScale,
    this.primaryTextSize = EmanArtSizes.kDefaultPrimaryTextSize,
  }) : // set the theme colors based on the mode
       primaryBackgroundColor = darkMode
           ? EmanArtColors.kBackgroundPrimaryD
           : EmanArtColors.kBackgroundPrimaryL,
       secondaryBackgroundColor = darkMode
           ? EmanArtColors.kBackgroundSecondaryD
           : EmanArtColors.kBackgroundSecondaryL,
       activeItemColor = darkMode
           ? EmanArtColors.kActiveItemD
           : EmanArtColors.kActiveItemL,
       inActiveItemColor = darkMode
           ? EmanArtColors.kInActiveItemD
           : EmanArtColors.kInActiveItemL,
       textColor = darkMode
           ? EmanArtColors.kTextColorD
           : EmanArtColors.kTextColorL,
       textFieldBorderColor = darkMode
           ? EmanArtColors.kTextFieldBorderD
           : EmanArtColors.kTextFieldBorderL,
       textFieldErrorBorderColor = darkMode
           ? EmanArtColors.kTextFieldErrorBorderD
           : EmanArtColors.kTextFieldErrorBorderL,
       minValueColor = darkMode
           ? EmanArtColors.kMinValueD
           : EmanArtColors.kMinValueL,
       maxValueColor = darkMode
           ? EmanArtColors.kMaxValueD
           : EmanArtColors.kMaxValueL;

  EmanArtThemeState copyWith({
    required bool darkMode,
    required double uiScale,
    required double primaryTextSize,
  }) {
    return EmanArtThemeState(
      darkMode: darkMode,
      uiScale: uiScale,
      primaryTextSize: primaryTextSize,
    );
  }
}

/// class to do operations on the properties
///
/// THIS CLASS IS FOR MUTATION OPERATIONS ONLY
/// TO ACCESS THE DATA, USE THE STATE CLASS ABOVE
class EmanArtThemeController extends StateNotifier<EmanArtThemeState> {
  EmanArtThemeController(super.state);

  // Theme settings controller to persist user settings
  final ThemeSettingsController _themeSettingsController =
      ThemeSettingsController.instance();

  // Method to update the state after mutation
  void updateState() {
    state = state.copyWith(
      darkMode: state.darkMode,
      uiScale: state.uiScale,
      primaryTextSize: state.primaryTextSize,
    );
    // Update the persistent local storage
    _themeSettingsController.updateThemeSettings(
      state.darkMode,
      state.uiScale,
      state.primaryTextSize,
    );
  }

  // Dark mode switch
  void switchDarkMode() {
    state.darkMode = !state.darkMode;
    updateState();
  }

  // Interface scaling methods
  void increaseUiScale() {
    if (state.uiScale < EmanArtSizes.kMaxUiScale) {
      state.uiScale = state.uiScale += 0.1;
    }
    updateState();
  }

  void decreaseUiScale() {
    if (state.uiScale > EmanArtSizes.kMinUiScale) {
      state.uiScale = state.uiScale -= 0.1;
    }
    updateState();
  }

  // Text scaling methods
  void setPrimaryTextSize(double newSize) {
    state.primaryTextSize = newSize;
    updateState();
  }

  void resetPrimaryTextSize() {
    state.primaryTextSize = EmanArtSizes.kDefaultPrimaryTextSize;
    updateState();
  }
}

/// exposing the controller using Riverpod
final emanArtThemeControllerProvider =
    StateNotifierProvider<EmanArtThemeController, EmanArtThemeState>((ref) {
      // Retrieve the theme settings from the persistent local storage
      var themeSettings = ThemeSettingsController.instance().getThemeSettings();
      return EmanArtThemeController(
        EmanArtThemeState(
          darkMode: themeSettings.darkMode,
          uiScale: themeSettings.uiScale,
          primaryTextSize: themeSettings.primaryTextSize,
        ),
      );
    });
