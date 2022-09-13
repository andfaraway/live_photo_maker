import 'package:flutter_test/flutter_test.dart';
import 'package:live_photo_maker/live_photo_maker.dart';
import 'package:live_photo_maker/live_photo_maker_platform_interface.dart';
import 'package:live_photo_maker/live_photo_maker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLivePhotoMakerPlatform
    with MockPlatformInterfaceMixin
    implements LivePhotoMakerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LivePhotoMakerPlatform initialPlatform = LivePhotoMakerPlatform.instance;

  test('$MethodChannelLivePhotoMaker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLivePhotoMaker>());
  });

  test('getPlatformVersion', () async {
    LivePhotoMaker livePhotoMakerPlugin = LivePhotoMaker();
    MockLivePhotoMakerPlatform fakePlatform = MockLivePhotoMakerPlatform();
    LivePhotoMakerPlatform.instance = fakePlatform;

    expect(await livePhotoMakerPlugin.getPlatformVersion(), '42');
  });
}
