import 'live_photo_maker_platform_interface.dart';

class LivePhotoMaker {
  /// [coverImage] The cover image of live photo
  /// [imagePath] Picture content of live photos
  /// [voicePath] Video content of live photos
  static Future<bool> create({
    required String coverImage,
    String? imagePath,
    String? voicePath,
    required int width,
    required int height,
  }) async {
    return LivePhotoMakerPlatform.instance.create(
      coverImage: coverImage,
      imagePath: imagePath,
      voicePath: voicePath,
      width: width,
      height: height,
    );
  }
}
