import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoTranslateScreenState {
  final String? videoFilePath;
  final String? audioFilePath;
  final VideoPlayerController? videoPlayerController;
  final ChewieController? chewieController;
  final bool? isSuccess;
  final bool? isFail;
  final bool? isLoadingTranscription;
  final bool? isLoadingTranslation;
  final String? message;
  final int? tabIndex;
  final String? selectedLanguage;
  final String? transcriptedText;
  final String? translatedText;

  VideoTranslateScreenState(
      {this.videoFilePath,
      this.audioFilePath,
      this.videoPlayerController,
      this.chewieController,
      this.isSuccess,
      this.isFail,
      this.message,
      this.isLoadingTranscription,
      this.isLoadingTranslation,
      this.tabIndex,
      this.selectedLanguage,
      this.transcriptedText,
      this.translatedText});

  factory VideoTranslateScreenState.empty() {
    return VideoTranslateScreenState(
        videoFilePath: "",
        audioFilePath: "",
        videoPlayerController: null,
        chewieController: null,
        message: "",
        isFail: false,
        isSuccess: false,
        isLoadingTranscription: false,
        isLoadingTranslation: false,
        tabIndex: 0,
        selectedLanguage: "",
        transcriptedText: "",
        translatedText: "");
  }

  VideoTranslateScreenState copyWith(
      {String? videoFilePath,
      String? audioFilePath,
      VideoPlayerController? videoPlayerController,
      ChewieController? chewieController,
      final bool? isSuccess,
      final bool? isFail,
      final bool? isLoadingTranscription,
      final bool? isLoadingTranslation,
      final String? message,
      final int? tabIndex,
      final String? selectedLanguage,
      final String? transcriptedText,
      final String? translatedText}) {
    return VideoTranslateScreenState(
        videoFilePath: videoFilePath ?? this.videoFilePath,
        audioFilePath: audioFilePath ?? this.audioFilePath,
        videoPlayerController:
            videoPlayerController ?? this.videoPlayerController,
        chewieController: chewieController ?? this.chewieController,
        message: message ?? this.message,
        isFail: isFail ?? this.isFail,
        isSuccess: isSuccess ?? this.isSuccess,
        isLoadingTranscription:
            isLoadingTranscription ?? this.isLoadingTranscription,
        isLoadingTranslation: isLoadingTranslation ?? this.isLoadingTranslation,
        tabIndex: tabIndex ?? this.tabIndex,
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
        translatedText: translatedText ?? this.translatedText,
        transcriptedText: transcriptedText ?? this.transcriptedText);
  }
}
