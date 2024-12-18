import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'live_photo_maker_method_channel.dart';

abstract class LivePhotoMakerPlatform extends PlatformInterface {
  /// Constructs a LivePhotoMakerPlatform.
  LivePhotoMakerPlatform() : super(token: _token);

  static final Object _token = Object();

  static final LivePhotoMakerPlatform _instance = MethodChannelLivePhotoMaker();

  /// The default instance of [LivePhotoMakerPlatform] to use.
  ///
  /// Defaults to [MethodChannelLivePhotoMaker].
  static LivePhotoMakerPlatform get instance => _instance;


  Future<bool> create({
    required String coverImage,
    String? imagePath,
    String? voicePath,
    required int width,
    required int height,
  }) {
    throw UnimplementedError('create() has not been implemented.');
  }
}
