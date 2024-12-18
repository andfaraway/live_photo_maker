# live_photo_maker

live photo maker for lock screen wallpaper.

![Image text](https://github.com/andfaraway/live_photo_maker/blob/master/example.gif)

Supports platform

|             | Android | iOS  | 
|-------------|---------|------|
| **Support** | ❌️ | ✔️ |


## Example
```dart
  bool success = await LivePhotoMaker.create(
        coverImage: coverImage!.path,
        imagePath: contentImage?.path,
        voicePath: contentVoice?.path,
        width: movWidth,
        height: movHeight);
```




