#import "LivePhotoMakerPlugin.h"
#if __has_include(<live_photo_maker/live_photo_maker-Swift.h>)
#import <live_photo_maker/live_photo_maker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "live_photo_maker-Swift.h"
#endif

@implementation LivePhotoMakerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLivePhotoPlugin registerWithRegistrar:registrar];
}
@end
