import 'package:emanart/src/app.dart';
import 'package:emanart/src/core/theme/theme_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive local persistent storage
  await Hive.initFlutter();
  Hive.registerAdapter(ThemeSettingsModelAdapter());
  await Hive.openBox<ThemeSettingsModel>("theme_settings");

  runApp(const ProviderScope(child: EmanArt()));
}
