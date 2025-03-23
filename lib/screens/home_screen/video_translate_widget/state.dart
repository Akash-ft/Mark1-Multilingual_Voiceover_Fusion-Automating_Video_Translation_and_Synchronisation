import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../../modules/transcribe_audio/model/transcription_result.dart';


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
  final TranscriptionResult? transcriptedResult; // ✅ Updated
  final String? translatedText;
  final bool? showAlertMessage;
  final bool? mainScreenLoader;

  VideoTranslateScreenState({
    this.videoFilePath,
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
    this.transcriptedResult, // ✅ Updated
    this.translatedText,
    this.showAlertMessage,
    this.mainScreenLoader,
  });

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
      transcriptedResult: null, // ✅ Set as null initially
      translatedText: "",
      showAlertMessage: false,
      mainScreenLoader: false,
    );
  }

  VideoTranslateScreenState copyWith({
    String? videoFilePath,
    String? audioFilePath,
    String? translatedAudioFilePath,
    String? translatedVideoFilePath,
    VideoPlayerController? videoPlayerController,
    ChewieController? chewieController,
    bool? isLoadingTranscription,
    bool? isLoadingTranslation,
    String? messageTitle,
    String? message,
    int? tabIndex,
    String? selectedLanguage,
    TranscriptionResult? transcriptedResult, // ✅ Updated
    String? translatedText,
    bool? showAlertMessage,
    bool? mainScreenLoader,
  }) {
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
      transcriptedResult: transcriptedResult ?? this.transcriptedResult,
      translatedText: translatedText ?? this.translatedText,
      showAlertMessage: showAlertMessage ?? this.showAlertMessage,
      mainScreenLoader: mainScreenLoader ?? this.mainScreenLoader,
    );
  }
}

