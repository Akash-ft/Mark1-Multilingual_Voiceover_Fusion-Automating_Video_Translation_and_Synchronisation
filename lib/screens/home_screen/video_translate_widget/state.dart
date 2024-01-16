import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoTranslateScreenState {
  final String? videoFilePath;
  final String? audioFilePath;
  final String? translatedAudioFilePath;
  final String? translatedVideoFilePath;
  final VideoPlayerController? videoPlayerController;
  final ChewieController? chewieController;
  final bool? isLoadingTranscription;
  final bool? isLoadingTranslation;
  final String? messageTitle;
  final String? message;
  final int? tabIndex;
  final String? selectedLanguage;
  final String? transcriptedText;
  final String? translatedText;
  final bool? showAlertMessage;

  VideoTranslateScreenState(
      {this.videoFilePath,
      this.audioFilePath,
      this.translatedAudioFilePath,
      this.translatedVideoFilePath,
      this.videoPlayerController,
      this.chewieController,
      this.message,
      this.messageTitle,
      this.isLoadingTranscription,
      this.isLoadingTranslation,
      this.tabIndex,
      this.selectedLanguage,
      this.transcriptedText,
      this.translatedText,
      this.showAlertMessage});
  factory VideoTranslateScreenState.empty() {
    return VideoTranslateScreenState(
        videoFilePath: "",
        audioFilePath: "",
        translatedAudioFilePath: "",
        translatedVideoFilePath: "",
        videoPlayerController: null,
        chewieController: null,
        messageTitle: "",
        message: "",
        isLoadingTranscription: false,
        isLoadingTranslation: false,
        tabIndex: 0,
        selectedLanguage: "",
        transcriptedText: "",
        translatedText: "",
        showAlertMessage: false);
  }
  VideoTranslateScreenState copyWith(
      {String? videoFilePath,
      String? audioFilePath,
      String? translatedAudioFilePath,
      String? translatedVideoFilePath,
      VideoPlayerController? videoPlayerController,
      ChewieController? chewieController,
      final bool? isLoadingTranscription,
      final bool? isLoadingTranslation,
      final String? messageTitle,
      final String? message,
      final int? tabIndex,
      final String? selectedLanguage,
      final String? transcriptedText,
      final String? translatedText,
      final bool? showAlertMessage}) {
    return VideoTranslateScreenState(
        videoFilePath: videoFilePath ?? this.videoFilePath,
        audioFilePath: audioFilePath ?? this.audioFilePath,
        translatedAudioFilePath:
            translatedAudioFilePath ?? this.translatedAudioFilePath,
        translatedVideoFilePath:
            translatedVideoFilePath ?? this.translatedVideoFilePath,
        videoPlayerController:
            videoPlayerController ?? this.videoPlayerController,
        chewieController: chewieController ?? this.chewieController,
        message: message ?? this.message,
        messageTitle: messageTitle ?? this.messageTitle,
        isLoadingTranscription:
            isLoadingTranscription ?? this.isLoadingTranscription,
        isLoadingTranslation: isLoadingTranslation ?? this.isLoadingTranslation,
        tabIndex: tabIndex ?? this.tabIndex,
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
        translatedText: translatedText ?? this.translatedText,
        transcriptedText: transcriptedText ?? this.transcriptedText,
        showAlertMessage: showAlertMessage ?? this.showAlertMessage);
  }
}
