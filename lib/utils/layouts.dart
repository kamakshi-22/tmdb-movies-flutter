
import 'package:get/get.dart';

class AppLayout {
  static getSize() {
    return Get.size;
  }

  static double getScreenHeight() {
    return Get.height;
  }

  static double getScreenWidth() {
    return Get.width;
  }

  static double getHeight(double pixels) {
    double x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }

  static double getWidth(double pixels) {
    double x = getScreenWidth() / pixels;
    return getScreenWidth() / x;
  }
}

