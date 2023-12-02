
import 'dart:io';
import 'package:b_native/utils/upload_file/upload_file_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'controller.dart';

class VideoTranslateWidget extends ConsumerStatefulWidget {
  const VideoTranslateWidget({super.key});

  @override
  ConsumerState<VideoTranslateWidget> createState() =>
      _VideoTranslateWidgetState();
}

class _VideoTranslateWidgetState extends ConsumerState<VideoTranslateWidget> {
  late TextEditingController _tController;

  @override
  void initState() {
    super.initState();
    _tController = TextEditingController();

  }

  @override
  void dispose() {
    _tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoTranslateController = ref.read(videoTranslateSProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center ,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          ref.watch(videoTranslateController.videoFile) == ""
              ? Icons.videocam_off
              : Icons.videocam,
          size: 30,
        ),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              var file =
              await ref
                  .read(uploadFileProvider)
                  .pickFileData(1,1);
             ref.read(videoTranslateController.videoFile.notifier).update((state) =>file.path);
            },
            child: Text("Upload  video  Gallery")),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              var file =await ref
                  .read(uploadFileProvider)
                  .pickFileData(2,1);
              ref.read(videoTranslateController.videoFile.notifier).update((state) =>file.path);
            }, child: Text("Record  video on Camera")),
        SizedBox(
          height: 30.0,
        ),

      ],
    );
  }
}
