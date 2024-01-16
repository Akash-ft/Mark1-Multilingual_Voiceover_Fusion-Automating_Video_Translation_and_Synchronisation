
import 'package:chewie_audio/chewie_audio.dart';
import 'package:video_player/video_player.dart';

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
  final String? transcriptedText;
  final String? translatedText;
  final bool? showAlertMessage;

  VoiceTranslateScreenState(
      {
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
        this.transcriptedText,
        this.translatedText,
        this.showAlertMessage});

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
        transcriptedText: "",
        translatedText: "",
        showAlertMessage: false);
  }

  VoiceTranslateScreenState copyWith(
      {
        String? audioFilePath,
        String? translatedAudioFilePath,
        VideoPlayerController? videoPlayerController,
        ChewieAudioController? chewieAudioController,
        final bool? isLoadingTranscription,
        final bool? isLoadingTranslation,
        final bool? isRecording,
        final String? messageTitle,
        final String? message,
        final int? tabIndex,
        final String? selectedLanguage,
        final String? transcriptedText,
        final String? translatedText,
        final bool? showAlertMessage}) {
    return VoiceTranslateScreenState(
        audioFilePath: audioFilePath ?? this.audioFilePath,
        translatedAudioFilePath:
        translatedAudioFilePath ?? this.translatedAudioFilePath,
        videoPlayerController:videoPlayerController ?? this.videoPlayerController,
        chewieAudioController: chewieAudioController ?? this.chewieAudioController,
        message: message ?? this.message,
        messageTitle: messageTitle ?? this.messageTitle,
        isLoadingTranscription:
        isLoadingTranscription ?? this.isLoadingTranscription,
        isLoadingTranslation: isLoadingTranslation ?? this.isLoadingTranslation,
        isRecording: isRecording ?? this.isRecording,
        tabIndex: tabIndex ?? this.tabIndex,
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
        translatedText: translatedText ?? this.translatedText,
        transcriptedText: transcriptedText ?? this.transcriptedText,
        showAlertMessage: showAlertMessage ?? this.showAlertMessage);
  }
}
