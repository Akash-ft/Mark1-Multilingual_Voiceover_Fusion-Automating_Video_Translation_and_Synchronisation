
import 'package:b_native/screens/home_screen/video_translate_widget/state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'controller.dart';

class VideoTranslateWidget extends ConsumerStatefulWidget {
  const VideoTranslateWidget({super.key});

  @override
  ConsumerState<VideoTranslateWidget> createState() =>
      _VideoTranslateWidgetState();
}

class _VideoTranslateWidgetState extends ConsumerState<VideoTranslateWidget> {

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     _initPlayer();
  //   });
  // }
  //
  // void _initPlayer() {
  //   ref
  //       .read(videoTranslateSProvider)
  //       .videoPlayerController = VideoPlayerController.network('');
  //   ref
  //       .read(videoTranslateSProvider)
  //       .chewieController = ChewieController(
  //       videoPlayerController: ref
  //           .watch(videoTranslateSProvider)
  //           .videoPlayerController,
  //       aspectRatio: 16 / 9
  //   );
  // }
  //
  // Future<void> _updateVideoPlayer(String fileName) async {
  //   File file = File(fileName);
  //   var vController=ref
  //       .read(videoTranslateSProvider)
  //       .videoPlayerController = VideoPlayerController.file(file);
  //   await vController.initialize();
  //   ref.read(videoTranslateSProvider).chewieController?.dispose();
  //   ref
  //       .read(videoTranslateSProvider)
  //       .chewieController = ChewieController(
  //       videoPlayerController: ref
  //           .watch(videoTranslateSProvider)
  //           .videoPlayerController,
  //       aspectRatio: 16 / 9
  //   );
  //   setState(() {});
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   ref.read(videoTranslateSProvider).videoPlayerController.dispose();
  //   ref.read(videoTranslateSProvider).chewieController?.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    handleStateChange(ref,context);
    final state = ref.watch(videoTranslateSProvider);
   // final cController = ref.watch(videoTranslateSProvider).chewieController;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        state.videoFilePath != ""
            ? state.chewieController != null
                ? Container(
                    height: 200,
                    width: 400,
                    child:
                    Chewie(controller: state.chewieController!,))
                : Center(
                  child: Icon(
                      Icons.video_call,
                      size: 30,
                    ),
                )
            : Center(
              child: Icon(
                  Icons.videocam_off,
                  size: 30,
                ),
            ),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              await ref.read(videoTranslateSProvider.notifier).pickVideoFile(1, 1);
              await ref.read(videoTranslateSProvider.notifier).extractAudio(state.videoFilePath!);
              // var file = await ref.read(uploadFileProvider).pickFileData(1, 1);
              // print("Upload video Gallery Selected file path: ${file.path}");
              // ref
              //     .read(videoTranslateController.videoFile.notifier)
              //     .update((state) => file.path);
              // _updateVideoPlayer(file.path);
            },
            child: Text("Upload  video  Gallery")),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
             await ref.read(videoTranslateSProvider.notifier).pickVideoFile(2, 1);
             await ref.read(videoTranslateSProvider.notifier).extractAudio(state.videoFilePath!);
              // var file = await ref.read(uploadFileProvider).pickFileData(2, 1);
              // print("Record video on Camera Selected file path: ${file.path}");
              // ref
              //     .read(videoTranslateController.videoFile.notifier)
              //     .update((state) => file.path);
             // _updateVideoPlayer(file.path);
            },
            child: Text("Record  video on Camera")),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  void handleStateChange(
      WidgetRef ref,
      BuildContext context,
      ) {
    ref.listen<VideoTranslateScreenState>(
        videoTranslateSProvider, (previous, next) {
      if (next.isSuccess!) {
        // showMessageDialog(
        //   isCancellable: false,
        //   context: context,
        //   title: "Success",
        //   message: 'Details has been updated',
        // );
        ref
            .read(videoTranslateSProvider.notifier)
            .initializeVideoPlayer(next.videoFilePath!);
      }
      // else {
      //   if (next.message != null) {
      //     showMessageDialog(
      //         context: context, title: "Error", message: next.message!);
      //   }
      // }
    });
  }
}
