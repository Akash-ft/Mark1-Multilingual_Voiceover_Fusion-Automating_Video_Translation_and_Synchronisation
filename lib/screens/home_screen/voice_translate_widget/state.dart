import 'package:chewie_audio/chewie_audio.dart';
import 'package:video_player/video_player.dart';
import '../../../modules/transcribe_audio/model/transcription_result.dart';


class VoiceTranslateScreenState {
  final String? audioFilePath;
  final String? translatedAudioFilePath;
  final VideoPlayerController? videoPlayerController;
  final ChewieAudioController? chewieAudioController;
  final bool? isLoadingTranscription;
  final bool? isLoadingTranslation;
  final bool? isRecording;
  final String? messageTitle;
  final String? message;
  final int? tabIndex;
  final String? selectedLanguage;
  final TranscriptionResult? transcriptedResult;
  final String? translatedText;
  final bool? showAlertMessage;
  final bool? mainScreenLoader;

  VoiceTranslateScreenState({
    this.audioFilePath,
    this.translatedAudioFilePath,
    this.videoPlayerController,
    this.chewieAudioController,
    this.message,
    this.messageTitle,
    this.isLoadingTranscription,
    this.isLoadingTranslation,
    this.isRecording,
    this.tabIndex,
    this.selectedLanguage,
    this.transcriptedResult, // ✅ Updated
    this.translatedText,
    this.showAlertMessage,
    this.mainScreenLoader,
  });

  factory VoiceTranslateScreenState.empty() {
    return VoiceTranslateScreenState(
      audioFilePath: "",
      translatedAudioFilePath: "",
      chewieAudioController: null,
      videoPlayerController: null,
      messageTitle: "",
      message: "",
      isLoadingTranscription: false,
      isLoadingTranslation: false,
      isRecording: false,
      tabIndex: 0,
      selectedLanguage: "",
      transcriptedResult: null, // ✅ Updated as null initially
      translatedText: "",
      showAlertMessage: false,
      mainScreenLoader: false,
    );
  }

  VoiceTranslateScreenState copyWith({
    String? audioFilePath,
    String? translatedAudioFilePath,
    VideoPlayerController? videoPlayerController,
    ChewieAudioController? chewieAudioController,
    bool? isLoadingTranscription,
    bool? isLoadingTranslation,
    bool? isRecording,
    String? messageTitle,
    String? message,
    int? tabIndex,
    String? selectedLanguage,
    TranscriptionResult? transcriptedResult,
    String? translatedText,
    bool? showAlertMessage,
    bool? mainScreenLoader,
  }) {
    return VoiceTranslateScreenState(
      audioFilePath: audioFilePath ?? this.audioFilePath,
      translatedAudioFilePath:
      translatedAudioFilePath ?? this.translatedAudioFilePath,
      videoPlayerController:
      videoPlayerController ?? this.videoPlayerController,
      chewieAudioController:
      chewieAudioController ?? this.chewieAudioController,
      message: message ?? this.message,
      messageTitle: messageTitle ?? this.messageTitle,
      isLoadingTranscription:
      isLoadingTranscription ?? this.isLoadingTranscription,
      isLoadingTranslation: isLoadingTranslation ?? this.isLoadingTranslation,
      isRecording: isRecording ?? this.isRecording,
      tabIndex: tabIndex ?? this.tabIndex,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      transcriptedResult: transcriptedResult ?? this.transcriptedResult,
      translatedText: translatedText ?? this.translatedText,
      showAlertMessage: showAlertMessage ?? this.showAlertMessage,
      mainScreenLoader: mainScreenLoader ?? this.mainScreenLoader,
    );
  }
}
