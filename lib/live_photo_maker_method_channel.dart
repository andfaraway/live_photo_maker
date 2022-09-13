import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'live_photo_maker_platform_interface.dart';

/// An implementation of [LivePhotoMakerPlatform] that uses method channels.
class MethodChannelLivePhotoMaker extends LivePhotoMakerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('live_photo_maker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> create(
      {required String firstImagePath,
        required String secondImagePath,
        required int width,
        required int height}) async {
    String movPath = await methodChannel.invokeMethod("image_to_mov",
        [secondImagePath, width.toString(), height.toString()]);
    String result = await methodChannel
        .invokeMethod("create_live_photo", [firstImagePath, movPath]);
    if(result == 'success'){
      return true;
    }else{
      return false;
    }
  }
}
