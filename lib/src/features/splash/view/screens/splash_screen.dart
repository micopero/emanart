import 'dart:async';

import 'package:emanart/src/core/constants/emanart_paths.dart';
import 'package:emanart/src/core/navigation/emanart_router.dart';
import 'package:emanart/src/core/theme/emanart_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Timer(
        const Duration(seconds: 3),
        // Use "goNamed" for splash screens with bottom navigation bars
        () => EmanArtRouter.router.goNamed(EmanArtRoutes.gallery.name),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // retrieve the theme state
    EmanArtThemeState themeState = ref.watch(emanArtThemeControllerProvider);

    return Scaffold(
      backgroundColor: themeState.primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(child: Image.asset(EmanArtPaths.kLogoSplash, scale: 2)),
        ),
      ),
    );
  }
}
