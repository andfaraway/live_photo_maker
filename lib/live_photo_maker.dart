
import 'live_photo_maker_platform_interface.dart';

class LivePhotoMaker {
  Future<String?> getPlatformVersion() {
    return LivePhotoMakerPlatform.instance.getPlatformVersion();
  }

  static Future<bool> create(
      {required String firstImagePath,
        required String secondImagePath,
        required int width,
        required int height}) async {
    return LivePhotoMakerPlatform.instance.create(firstImagePath: firstImagePath, secondImagePath: secondImagePath, width: width, height: height);
  }
}
