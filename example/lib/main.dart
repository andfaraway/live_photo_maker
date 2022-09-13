import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:live_photo_maker/live_photo_maker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'image_editor_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LivePhotoPage(),);
  }
}

class LivePhotoPage extends StatefulWidget {
  const LivePhotoPage({Key? key}) : super(key: key);

  @override
  State<LivePhotoPage> createState() => _LivePhotoPageState();
}

class _LivePhotoPageState extends State<LivePhotoPage> {
  File? firstImage;
  File? secondImage;
  late int movWidth;
  late int movHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Photo"),
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
                    child: firstImage != null
                        ? Image.file(firstImage!)
                        : Container(
                      color: Colors.green,
                      height: double.infinity,
                      child: const Center(
                        child: Text(
                          'first photo',
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
                    child: secondImage != null
                        ? Image.file(secondImage!)
                        : Container(
                      color: Colors.cyan,
                      height: double.infinity,
                      child: const Center(
                        child: Text(
                          'second photo',
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
            child: Center(
              child: TextButton(
                onPressed: () async {
                  await create();
                },
                child: const Text(
                  'create',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> pickPhoto(int index) async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
        ));
    if (result == null) {
      return;
    }

    File? imageFile = await result.first.originFile;
    if (!mounted) return;
    File? file =

    await Navigator.push(context, MaterialPageRoute(builder: (context)=>SimpleImageEditor(imageFile!)));

    if (index == 0) {
      firstImage = file;
    } else {
      secondImage = file;
      movWidth = result.first.width;
      movHeight = result.first.height;
    }
    setState(() {});
  }

  Future<void> create() async {
    if (firstImage == null || secondImage == null) {
      return;
    }
    bool success =  await LivePhotoMaker.create(firstImagePath: firstImage!.path, secondImagePath: secondImage!.path, width: movWidth, height: movHeight);
    if(success){
      Fluttertoast.showToast(msg: 'success');
    }else{
      Fluttertoast.showToast(msg: 'failure');
    }
  }
}
