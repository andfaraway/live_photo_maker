//
//  [Author] libin (https://github.com/andfaraway/nothing)
//  [Date] 2022-05-25 11:21:13
//
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_photo_maker/live_photo_maker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LivePhotoPage(),
      builder: EasyLoading.init(),
    );
  }
}

class LivePhotoPage extends StatefulWidget {
  const LivePhotoPage({super.key});

  @override
  State<LivePhotoPage> createState() => _LivePhotoPageState();
}

class _LivePhotoPageState extends State<LivePhotoPage> {
  File? coverImage;
  File? contentImage;
  File? contentVoice;
  late int movWidth;
  late int movHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Photo Maker"),
        leading: const SizedBox.shrink(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickPhoto(0);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: coverImage != null
                        ? Image.file(coverImage!)
                        : Container(
                            color: Colors.green,
                            height: double.infinity,
                            child: const Center(
                              child: Text(
                                'Cover Image',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickPhoto(1);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: contentImage != null
                        ? Image.file(contentImage!)
                        : contentVoice != null
                            ? const Center(
                                child: Icon(Icons.play_circle, size: 88),
                              )
                            : Container(
                                color: Colors.cyan,
                                height: double.infinity,
                                child: const Center(
                                  child: Text(
                                    'Content',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(builder: (context) {
              return Center(
                child: TextButton(
                  onPressed: () async {
                    await create(context);
                  },
                  child: const Text(
                    'create',
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Future<void> pickPhoto(int index) async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: index == 0 ? RequestType.image : RequestType.common,
        ));
    if (result == null) {
      return;
    }

    movWidth = result.first.width;
    movHeight = result.first.height;

    File? pickFile = await result.first.originFile;
    if (!mounted || pickFile == null) return;

    if (fileIsVideo(pickFile.path)) {
      contentImage = null;
      contentVoice = pickFile;
      setState(() {});
      return;
    }

    if (index == 0) {
      coverImage = pickFile;
    } else {
      contentImage = pickFile;
      contentVoice = null;
    }
    setState(() {});
  }

  Future<void> pickVideo(int index) async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.video,
        ));
    if (result == null) {
      return;
    }
    contentVoice = await result.first.originFile;
    setState(() {});
  }

  Future<void> create(BuildContext context) async {
    if (coverImage == null || (contentImage == null && contentVoice == null)) {
      return;
    }

    EasyLoading.show(status: 'waiting..', dismissOnTap: false);
    bool success = await LivePhotoMaker.create(
        coverImage: coverImage!.path,
        imagePath: contentImage?.path,
        voicePath: contentVoice?.path,
        width: movWidth,
        height: movHeight);

    EasyLoading.dismiss();

    if (context.mounted) {
      final s = Scaffold.of(context).showBottomSheet((context) {
        return Container(
          width: double.infinity,
          color: Colors.black87,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Text(
            success ? 'success' : 'failure',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      });

      Future.delayed(const Duration(seconds: 1), () {
        print('123');
        s.close();
      });
    }
  }

  bool fileIsVideo(String filePath) {
    final file = File(filePath);
    final extension = file.path.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(extension)) {
      return false;
    } else if (['mp4', 'mkv', 'avi', 'mov', 'flv'].contains(extension)) {
      return true;
    } else {
      return false;
    }
  }
}
