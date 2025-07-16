import 'package:emanart/src/features/gallery/view/screens/dashboard_screen.dart';
import 'package:emanart/src/features/navigation_bar/view/screens/emanart_navigation_bar.dart';
import 'package:emanart/src/features/splash/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum EmanArtRoutes { splash, gallery, settings }

class EmanArtRouter {
  // ensure this class cannot be initialized
  EmanArtRouter._();

  // private navigator key
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorGallery = GlobalKey<NavigatorState>();
  //static final _rootNavigatorSettings = GlobalKey<NavigatorState>();

  // static is very important to prevent
  // the splash screen from always replaying
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/${EmanArtRoutes.splash.name}",
    routes: <RouteBase>[
      // Splash Branch
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: "/${EmanArtRoutes.splash.name}",
        name: EmanArtRoutes.splash.name,
        builder: (context, state) => SplashScreen(key: state.pageKey),
      ),

      // UTS:ME Connect - Navigation Bar Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            EmanArtNavigationBar(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          // Dashboard Branch
          StatefulShellBranch(
            navigatorKey: _rootNavigatorGallery,
            routes: [
              GoRoute(
                path: "/${EmanArtRoutes.gallery.name}",
                name: EmanArtRoutes.gallery.name,
                builder: (context, state) => GalleryScreen(key: state.pageKey),
              ),
            ],
          ),

          // // Power Branch
          // StatefulShellBranch(
          //   navigatorKey: _rootNavigatorPower,
          //   routes: [
          //     GoRoute(
          //       path: "/${UTSMEConnectRoutes.power.name}",
          //       name: UTSMEConnectRoutes.power.name,
          //       builder: (context, state) => PowerScreen(key: state.pageKey),
          //     ),
          //   ],
          // ),

          // // Temperature Branch
          // StatefulShellBranch(
          //   navigatorKey: _rootNavigatorTemperature,
          //   routes: [
          //     GoRoute(
          //       path: "/${UTSMEConnectRoutes.temperature.name}",
          //       name: UTSMEConnectRoutes.temperature.name,
          //       builder: (context, state) =>
          //           TemperatureScreen(key: state.pageKey),
          //     ),
          //   ],
          // ),

          // // Settings Branch
          // StatefulShellBranch(
          //   navigatorKey: _rootNavigatorSettings,
          //   routes: [
          //     GoRoute(
          //       path: "/${EmanArtRoutes.settings.name}",
          //       name: EmanArtRoutes.settings.name,
          //       builder: (context, state) => SettingsScreen(key: state.pageKey),
          //     ),
          //   ],
          // ),
        ],
      ),
    ],
  );
}
