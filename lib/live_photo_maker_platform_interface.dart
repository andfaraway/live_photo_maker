import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'live_photo_maker_method_channel.dart';

abstract class LivePhotoMakerPlatform extends PlatformInterface {
  /// Constructs a LivePhotoMakerPlatform.
  LivePhotoMakerPlatform() : super(token: _token);

  static final Object _token = Object();

  static LivePhotoMakerPlatform _instance = MethodChannelLivePhotoMaker();

  /// The default instance of [LivePhotoMakerPlatform] to use.
  ///
  /// Defaults to [MethodChannelLivePhotoMaker].
  static LivePhotoMakerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LivePhotoMakerPlatform] when
  /// they register themselves.
  static set instance(LivePhotoMakerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> create(
      {required String firstImagePath,
        required String secondImagePath,
        required int width,
        required int height}) {
    throw UnimplementedError('create() has not been implemented.');
  }
}
