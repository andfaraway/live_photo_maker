# live_photo_maker

live photo maker for lock screen wallpaper.

![Image text](https://github.com/andfaraway/live_photo_maker/blob/master/example.gif)

Supports platform

|             | Android | iOS  | 
|-------------|---------|------|
| **Support** | ❌️ | ✔️ |

## Usage

To use this plugin, add `live_photo` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Example
```dart
    bool success =  await LivePhotoMaker.create(firstImagePath: firstImagePath, secondImagePath: secondImagePath, width: movWidth, height: movHeight);
```




