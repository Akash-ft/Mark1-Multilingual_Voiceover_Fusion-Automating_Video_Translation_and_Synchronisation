
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoTranslateScreenState {
  final String? videoFilePath;
  final String? audioFilePath;
  final VideoPlayerController? videoPlayerController;
  final ChewieController? chewieController;
  final bool? isSuccess;
  final bool? isFail;
  final bool? isLoading;
  final String? erorrMSg;

  VideoTranslateScreenState(
      {this.videoFilePath,
      this.audioFilePath,
      this.videoPlayerController,
      this.chewieController,
      this.isSuccess,
      this.isFail,
      this.erorrMSg,
      this.isLoading});

  factory VideoTranslateScreenState.empty() {
    return VideoTranslateScreenState(
        videoFilePath: "",
        audioFilePath: "",
        videoPlayerController: null,
        chewieController: null,
        erorrMSg: "",
        isFail: false,
        isSuccess: false,
        isLoading: false);
  }

  VideoTranslateScreenState copyWith({
    String? videoFilePath,
    String? audioFilePath,
    VideoPlayerController? videoPlayerController,
    ChewieController? chewieController,
    final bool? isSuccess,
    final bool? isFail,
    final bool? isLoading,
    final String? erorrMSg,
  }) {
    return VideoTranslateScreenState(
        videoFilePath: videoFilePath ?? this.videoFilePath,
        audioFilePath: audioFilePath ?? this.audioFilePath,
        videoPlayerController:
            videoPlayerController ?? this.videoPlayerController,
        chewieController: chewieController ?? this.chewieController,
        erorrMSg: erorrMSg ?? this.erorrMSg,
        isFail: isFail ?? this.isFail,
        isSuccess: isSuccess ?? this.isSuccess,
        isLoading: isLoading ?? this.isLoading);
  }
}
