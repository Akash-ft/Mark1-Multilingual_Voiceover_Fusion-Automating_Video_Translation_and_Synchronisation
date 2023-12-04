import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

final videoPlayerProvider = Provider((ref) => VideoPlayer());

class VideoPlayer {
  Future<ChewieController> initizeVideoPlayer(
      String? filepath, VideoPlayerController? videoPlayerController) async {
    if (filepath == null) {
      videoPlayerController = VideoPlayerController.network('');
    } else {
      videoPlayerController = VideoPlayerController.file(File(filepath));
      await videoPlayerController.initialize();
    }
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
    );
    return chewieController;
  }


  Chewie videoPlayer(ChewieController cController) {
    return Chewie(controller: cController);
  }
}
