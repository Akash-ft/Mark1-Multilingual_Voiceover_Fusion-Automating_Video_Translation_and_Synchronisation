import 'dart:io';

import 'package:MVF/screens/home_screen/video_translate_widget/state.dart';
import 'package:chewie/chewie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../modules/FFmpeg_tools/FFmpeg_tool_provider.dart';
import '../../../modules/text_2_speech/tts_provider.dart';
import '../../../modules/transcribe_audio/transcribe_audio_provider.dart';
import '../../../modules/translate_text/translate_text_provider.dart';
import '../../../utils/upload_file/upload_file_provider.dart';

final videoTranslateSProvider = StateNotifierProvider.autoDispose<
        VideoTranslateScreenController, VideoTranslateScreenState>(
    (ref) => VideoTranslateScreenController(
          ref.read(uploadFileProvider),
          ref.read(FFmpegToolProvider),
          ref.read(transcribeAudioProvider),
          ref.read(translateTextProvider),
          ref.read(Text2SpeechProvider),
        ));
class VideoTranslateScreenController
    extends StateNotifier<VideoTranslateScreenState> {
  VideoTranslateScreenController(this.uploadFile, this.ffmpegTools,
      this.transcriptAudio, this.translateText, this.text2speech)
      : super(VideoTranslateScreenState.empty());
  UploadFile uploadFile;
  FFmpegTools ffmpegTools;
  TranscribeAudio transcriptAudio;
  TranslateText translateText;
  Text2Speech text2speech;

  Future<void> pickVideoFile(int target, int format) async {
    var file = await uploadFile.pickFileData(target, format);
    print("File path ${file.path}");
    if (file.path != "") {
      await initializeVideoPlayer(file.path);
    }
  }
  Future<void> extractAudio() async {
    var file = await ffmpegTools.extractAudioFromVideo(state.videoFilePath!);
    if (file != "") {
      state = state.copyWith(audioFilePath: file);
      print("Extract Audio file path ${file}");
      await transcription();
    } else {
      print("Something went wrong in extract audio file path");
      state = state.copyWith(
          showAlertMessage: true,
          message: "Failed to extract audio",
          messageTitle: "Error-ExtractAudio");
    }
  }
  Future<void> initializeVideoPlayer(String filePath) async {
    File file = File(filePath);
    print("video player initializes");
    final videoPlayerController = VideoPlayerController.file(file);
    await videoPlayerController.initialize();
    state = state.copyWith(
      videoFilePath: filePath,
      videoPlayerController: videoPlayerController,
      chewieController: ChewieController(
        videoPlayerController: videoPlayerController,
      ),
    );
  }
  Future<void> transcription() async {
    if (state.audioFilePath != "") {
      state = state.copyWith(isLoadingTranscription: true);
      //COMMENTED FOR TESTING PURPOSE
      // var transcriptedContent =
      //  await transcriptAudio.transcribeAudio(state.audioFilePath!);
      await Future.delayed(Duration(seconds: 1));
      var transcriptedContent =
          "Excellence is never an accident. It is always the result of high intention, sincere effort, and intelligent execution. It represents the wise choice of many alternatives. Choice, not chance, determines your destiny.";
      print("transcription ${transcriptedContent}");
      state = state.copyWith(
          transcriptedText: transcriptedContent, isLoadingTranscription: false);
    } else {
      print("Audio file path is missing for transcription");
      state = state.copyWith(
          showAlertMessage: true,
          message: "Something went wrong while Transcription",
          messageTitle: "Error-Transcription");
    }
  }

  Future<void> translation() async {
    if (state.transcriptedText != "" && state.selectedLanguage != "") {
      state = state.copyWith(isLoadingTranslation: true);
      var translatedContent = await translateText.translateTextV1(
          state.transcriptedText!, state.selectedLanguage!);
      state = state.copyWith(
          translatedText: translatedContent, isLoadingTranslation: false);
    } else {
      print("Transacripted text or Selected language is empty");
      state = state.copyWith(
          showAlertMessage: true,
          message: "Something went wrong while Translation",
          messageTitle: "Error-Translation");
    }
  }

  Future<void> readText(String text, String langCode) async {
    await text2speech.speak(text, langCode);
  }

  Future<void> saveSpeechAsAudioFile(String text, String langCode) async {
    var translatedAudioFile =
        await text2speech.saveSpeechToFile(text, langCode);
    if (translatedAudioFile != "") {
      state = state.copyWith(translatedAudioFilePath: translatedAudioFile);
    } else {
      print("Translated Audio file path is missing for transcription");
      state = state.copyWith(
          showAlertMessage: true,
          message: "Failed to save the Speech file",
          messageTitle: "Error-SaveSpeechAsAudioFile");
    }
  }

  Future<void> generateVoiceOverForVideo() async {
    await saveSpeechAsAudioFile(state.translatedText!, state.selectedLanguage!);
    var muteVideoFilePath =
        await ffmpegTools.removeAudioFromVideo(state.videoFilePath!);
    if (muteVideoFilePath != "" && state.translatedAudioFilePath != "") {
      double? videoDuration =
          await ffmpegTools.getMediaDuration(state.audioFilePath!);
      double? translatedAudioDuration =
          await ffmpegTools.getMediaDuration(state.translatedAudioFilePath!);
      //var syncedtranslatedAudioFilePath= await text2speech.saveSyncSpeechToFile(state.translatedText!, state.selectedLanguage!, videoDuration!, translatedAudioDuration!);
      var mergedVideoFile = await ffmpegTools.mergeAudioInVideo(
          muteVideoFilePath, state.translatedAudioFilePath!);
      if (mergedVideoFile != "") {
        await initializeVideoPlayer(mergedVideoFile);
        state = state.copyWith(
            showAlertMessage: true,
            message: "Translated video is loaded in the player",
            messageTitle: "Success-GenerateVoiceOverForVideo");
      } else {
        print("Mereged video file path is missing");
        state = state.copyWith(
            showAlertMessage: true,
            message: "Failed to Generate Voice Over",
            messageTitle: "Error-GenerateVoiceOverForVideo");
      }
    } else {
      print(
          "file path is missing for muteVideoFilePath or translatedAudioFilePath");
      state = state.copyWith(
          showAlertMessage: true,
          message: "Something went wrong in Translated Audio File",
          messageTitle: "Error-GenerateVoiceOverForVideo");
    }
  }
  Future<void> setLanguage(String languageCode) async {
    state = state.copyWith(selectedLanguage: languageCode);
    await translation();
  }
  void switchTab(int tabIndex) {
    state = state.copyWith(tabIndex: tabIndex);
  }
  void hideAlertMessage() {
    state = state.copyWith(showAlertMessage: false);
  }
}
