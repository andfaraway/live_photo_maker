import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'live_photo_maker_platform_interface.dart';

/// An implementation of [LivePhotoMakerPlatform] that uses method channels.
class MethodChannelLivePhotoMaker extends LivePhotoMakerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('live_photo_maker');

  @override
  Future<bool> create({
    required String coverImage,
    String? imagePath,
    String? voicePath,
    required int width,
    required int height,
  }) async {
    assert(Platform.isIOS, 'Live photo can only be used on the iOS platform.');

    assert(
        ((imagePath ?? '').isNotEmpty && (voicePath ?? '').isEmpty) ||
            ((imagePath ?? '').isEmpty && (voicePath ?? '').isNotEmpty),
        "Either imagePath or voicePath should have a value, and both cannot be empty.");

    late String movPath;
    if ((voicePath ?? '').isNotEmpty) {
      movPath = voicePath!;
    } else {
      movPath = await methodChannel.invokeMethod("image_to_mov", [imagePath, width.toString(), height.toString()]);
    }

    String result = await methodChannel.invokeMethod("create_live_photo", [coverImage, movPath]);
    if (result == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
