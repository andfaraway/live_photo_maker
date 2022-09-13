import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_photo_maker/live_photo_maker_method_channel.dart';

void main() {
  MethodChannelLivePhotoMaker platform = MethodChannelLivePhotoMaker();
  const MethodChannel channel = MethodChannel('live_photo_maker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
