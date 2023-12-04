import 'dart:io';
import 'package:b_native/utils/upload_file/upload_file_provider.dart';
import 'package:b_native/utils/video_player/video_player_provider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'controller.dart';

class VideoTranslateWidget extends ConsumerStatefulWidget {
  const VideoTranslateWidget({super.key});

  @override
  ConsumerState<VideoTranslateWidget> createState() =>
      _VideoTranslateWidgetState();
}

class _VideoTranslateWidgetState extends ConsumerState<VideoTranslateWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      _initPlayer();
    });
  }

  void _initPlayer() {
    ref
        .read(videoTranslateSProvider)
        .videoPlayerController = VideoPlayerController.network('');
    ref
        .read(videoTranslateSProvider)
        .chewieController = ChewieController(
        videoPlayerController: ref
            .watch(videoTranslateSProvider)
            .videoPlayerController,
        aspectRatio: 16 / 9
    );
  }

  Future<void> _updateVideoPlayer(String fileName) async {
    File file = File(fileName);
    var vController=ref
        .read(videoTranslateSProvider)
        .videoPlayerController = VideoPlayerController.file(file);
    await vController.initialize();
    ref.read(videoTranslateSProvider).chewieController?.dispose();
    ref
        .read(videoTranslateSProvider)
        .chewieController = ChewieController(
        videoPlayerController: ref
            .watch(videoTranslateSProvider)
            .videoPlayerController,
        aspectRatio: 16 / 9
    );
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(videoTranslateSProvider).videoPlayerController.dispose();
    ref.read(videoTranslateSProvider).chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoTranslateController = ref.watch(videoTranslateSProvider);
    final cController = ref.watch(videoTranslateSProvider).chewieController;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        videoTranslateController.videoFile != null
            ? cController != null
                ? Container(
                    height: 200,
                    width: 400,
                    child:
                        ref.watch(videoPlayerProvider).videoPlayer(cController))
                : Icon(
                    Icons.warning,
                    size: 30,
                  )
            : Icon(
                Icons.videocam_off,
                size: 30,
              ),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              var file = await ref.read(uploadFileProvider).pickFileData(1, 1);
              print("Upload video Gallery Selected file path: ${file.path}");
              ref
                  .read(videoTranslateController.videoFile.notifier)
                  .update((state) => file.path);
              _updateVideoPlayer(file.path);
            },
            child: Text("Upload  video  Gallery")),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              var file = await ref.read(uploadFileProvider).pickFileData(2, 1);
              print("Record video on Camera Selected file path: ${file.path}");
              ref
                  .read(videoTranslateController.videoFile.notifier)
                  .update((state) => file.path);
              _updateVideoPlayer(file.path);
            },
            child: Text("Record  video on Camera")),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
