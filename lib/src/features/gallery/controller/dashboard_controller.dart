import 'dart:async';
import 'package:emanart/src/features/gallery/data/remote/gallery_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// class to contain the properties
class GalleryState {
  double speed;
  double suspension;

  GalleryState({required this.speed, required this.suspension});

  GalleryState copyWith({required double speed, required double suspension}) {
    return GalleryState(speed: speed, suspension: suspension);
  }
}

/// class to do operations on the properties
class GalleryController extends StateNotifier<GalleryState> {
  GalleryController(super.state) {
    periodicallyUpdateDashboardData();
  }

  void periodicallyUpdateDashboardData() async {
    Timer.periodic(const Duration(microseconds: 1), (timer) {
      state.speed = GalleryData.fetchSpeed();
      state.suspension = GalleryData.fetchSuspension();
    });
    state = state.copyWith(speed: state.speed, suspension: state.suspension);
  }
}

/// exposing the controller using Riverpod
final dashboardControllerProvider =
    StateNotifierProvider<GalleryController, GalleryState>((ref) {
      return GalleryController(
        GalleryState(
          speed: GalleryData.fetchSpeed(),
          suspension: GalleryData.fetchSuspension(),
        ),
      );
    });
