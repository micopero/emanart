import 'dart:math';

// Singleton class to contact the endpoint
// to fetch information about the car dashboard
class GalleryData {
  GalleryData._();

  static double fetchSpeed() {
    //fetch the charge
    return Random().nextInt(2).toDouble();
  }

  static double fetchSuspension() {
    //fetch the suspension
    return Random().nextInt(2).toDouble();
  }
}
