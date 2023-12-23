
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
  final String? message;

  VideoTranslateScreenState(
      {this.videoFilePath,
      this.audioFilePath,
      this.videoPlayerController,
      this.chewieController,
      this.isSuccess,
      this.isFail,
      this.message,
      this.isLoading});

  factory VideoTranslateScreenState.empty() {
    return VideoTranslateScreenState(
        videoFilePath: "",
        audioFilePath: "",
        videoPlayerController: null,
        chewieController: null,
        message: "",
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
    final String? message,
  }) {
    return VideoTranslateScreenState(
        videoFilePath: videoFilePath ?? this.videoFilePath,
        audioFilePath: audioFilePath ?? this.audioFilePath,
        videoPlayerController:
            videoPlayerController ?? this.videoPlayerController,
        chewieController: chewieController ?? this.chewieController,
        message: message ?? this.message,
        isFail: isFail ?? this.isFail,
        isSuccess: isSuccess ?? this.isSuccess,
        isLoading: isLoading ?? this.isLoading);
  }
}
