import 'dart:io';
import 'package:b_native/screens/home_screen/video_translate_widget/state.dart';
import 'package:chewie/chewie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/upload_file/upload_file_provider.dart';

final videoTranslateSProvider = StateNotifierProvider.autoDispose<
        VideoTranslateScreenController, VideoTranslateScreenState>(
    (ref) => VideoTranslateScreenController(
          ref.read(uploadFileProvider),
        ));

class VideoTranslateScreenController
    extends StateNotifier<VideoTranslateScreenState> {
  VideoTranslateScreenController(
    this.upload,
    // this.videoPlayerController
  ) : super(VideoTranslateScreenState.empty());
  UploadFile upload;

  // final VideoPlayerController? videoPlayerController;

  // var videoFile = StateProvider.autoDispose((ref) => "");
  // var audioFile = StateProvider.autoDispose((ref) => "");
  // late VideoPlayerController videoPlayerController;
  // ChewieController? chewieController;

  Future<void> pickedFile(int target, int format) async {
    var file = await upload.pickFileData(target, format);
    print("File path ${file.path}");
    if (file.path != null) {
      state = state.copyWith(videoFilePath: file.path, isSuccess: true);
    }
  }

  Future<void> initializeVideoPlayer(String fileName) async {
    File file = File(fileName);
    print("video player initializes");
    final videoPlayerController = VideoPlayerController.file(file);
    await videoPlayerController.initialize();
    state = state.copyWith(
      videoPlayerController: videoPlayerController,
      chewieController: ChewieController(
        videoPlayerController: videoPlayerController,
      ),
    );
  }
}
