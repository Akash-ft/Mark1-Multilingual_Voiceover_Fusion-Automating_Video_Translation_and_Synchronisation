import 'dart:io';
import 'dart:math';

import 'package:MVF/screens/home_screen/video_translate_widget/state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
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
      state = state.copyWith(audioFilePath: file, isLoadingTranscription: true);
      print("Extract Audio file path ${file}");
      await transcription();
    } else {
      print("Something went wrong in extract audio file path");
      state = state.copyWith(
          isLoadingTranscription: false,
          showAlertMessage: true,
          message: "Failed to extract audio",
          messageTitle: "Error-ExtractAudio");
    }
  }

  Future<List<Subtitle>> generateSubtitles() async {
    List<String> words = state.translatedText!.split('.');
    double duration = await ffmpegTools.getMediaDuration(state.audioFilePath!);
    Duration totalDuration = Duration(seconds: duration!.toInt());
    double wordDuration = (totalDuration.inSeconds / words.length);
    List<Subtitle> subtitles = [];
    for (int i = 0; i < words.length; i++) {
      Duration start = Duration(seconds: (i * wordDuration).round());
      Duration end = Duration(seconds: ((i + 1) * wordDuration).round());
      if (end > totalDuration) {
        end = totalDuration;
      }
      subtitles.add(
        Subtitle(
          index: i,
          start: start,
          end: end,
          text: words[i],
        ),
      );
    }
    return subtitles;
  }

  Future<void> initializeVideoPlayer(String filePath,
      {bool enableSubtitle = false}) async {
    File file = File(filePath);
    print("video player initializes");
    final videoPlayerController = VideoPlayerController.file(file);
    await videoPlayerController.initialize();
    state = state.copyWith(
      videoFilePath: filePath,
      videoPlayerController: videoPlayerController,
      chewieController: enableSubtitle
          ? ChewieController(
              videoPlayerController: videoPlayerController,
              subtitle: Subtitles(await generateSubtitles()),
              subtitleBuilder: (context, subtitle) => Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          : ChewieController(
              videoPlayerController: videoPlayerController,
            ),
    );
  }

  Future<void> transcription() async {
    if (state.audioFilePath != "") {
      state = state.copyWith(isLoadingTranscription: true);
      //COMMENTED FOR TESTING PURPOSE
      var transcriptedContent =
       await transcriptAudio.transcribeAudioV1(state.audioFilePath!);
      // await Future.delayed(Duration(seconds: 1));
      // var transcriptedContent =
      //     "Excellence is never an accident. It is always the result of high intention, sincere effort, and intelligent execution. It represents the wise choice of many alternatives. Choice, not chance, determines your destiny.";
      print("transcription ${transcriptedContent.toString()}");
      state = state.copyWith(
          transcriptedResult: transcriptedContent, isLoadingTranscription: false);
    } else {
      print("Audio file path is missing for transcription");
      state = state.copyWith(
          showAlertMessage: true,
          message: "Something went wrong while Transcription",
          messageTitle: "Error-Transcription");
    }
  }

  Future<void> translation() async {
    if (state.transcriptedResult != null && state.selectedLanguage != "") {
      state = state.copyWith(isLoadingTranslation: true);
      var translatedContent = await translateText.translateTextV1(
          state.transcriptedResult!.transcript, state.selectedLanguage!);
      // await Future.delayed(Duration(seconds: 1));
      // var translatedContent = "சிறந்து விளங்குவது ஒருபோதும் விபத்து அல்ல. இது எப்போதும் உயர்ந்த எண்ணம், நேர்மையான முயற்சி மற்றும் புத்திசாலித்தனமான செயல்பாட்டின் விளைவாகும். இது பல மாற்றுகளின் புத்திசாலித்தனமான தேர்வைக் குறிக்கிறது. தேர்வு, வாய்ப்பு அல்ல, உங்கள் விதியை தீர்மானிக்கிறது";
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
    state= state.copyWith(mainScreenLoader: true);
    var muteVideoFilePath = "";
    var adjustedTranslatedAudioFile = "";
    if (state.translatedText != "" && state.selectedLanguage != "") {
      await saveSpeechAsAudioFile(
          state.translatedText!, state.selectedLanguage!);
    } else {
      state = state.copyWith(
          showAlertMessage: true,
          mainScreenLoader: false,
          message: state.translatedText == ""
              ? "Please upload/record video"
              : "Please select language",
          messageTitle: "Error-GenerateVoiceOverForVideo");
    }
    if (state.videoFilePath != "") {
      muteVideoFilePath =
          await ffmpegTools.removeAudioFromVideo(state.videoFilePath!);
    } else {
      state = state.copyWith(
          showAlertMessage: true,
          mainScreenLoader: false,
          message: "Please upload/record video",
          messageTitle: "Error-GenerateVoiceOverForVideo");
    }
    if (state.audioFilePath != "" && state.translatedAudioFilePath != "") {
      double playBackSpeed = calculatePlaybackSpeed(
          await ffmpegTools.getMediaDuration(state.audioFilePath!),
          await ffmpegTools.getMediaDuration(state.translatedAudioFilePath!));
      adjustedTranslatedAudioFile = await ffmpegTools.adjustAudioSpeed(
          state.translatedAudioFilePath!, playBackSpeed);
    } else {
      state = state.copyWith(
          showAlertMessage: true,
          mainScreenLoader: false,
          message: "Something went wrong while adjust audio",
          messageTitle: "Error-GenerateVoiceOverForVideo");
    }
    if (muteVideoFilePath != "" && adjustedTranslatedAudioFile != "") {
      var mergedVideoFile = await ffmpegTools.mergeAudioInVideo(
          muteVideoFilePath, adjustedTranslatedAudioFile!);
      if (mergedVideoFile != "") {
        await initializeVideoPlayer(mergedVideoFile, enableSubtitle: true);
        state = state.copyWith(
            showAlertMessage: true,
            mainScreenLoader: false,
            message: "Translated video is loaded in the player",
            messageTitle: "Success-GenerateVoiceOverForVideo");
      } else {
        print("Mereged video file path is missing");
        state = state.copyWith(
            showAlertMessage: true,
            mainScreenLoader: false,
            message: "Failed to Generate Voice Over",
            messageTitle: "Error-GenerateVoiceOverForVideo");
      }
    } else {
      print(
          "file path is missing for muteVideoFilePath or translatedAudioFilePath");
      state = state.copyWith(
          showAlertMessage: true,
          mainScreenLoader: false,
          message: "Something went wrong in Translated Audio File",
          messageTitle: "Error-GenerateVoiceOverForVideo");
    }
  }

  double calculatePlaybackSpeed(
      double videoDuration, double translatedAudioDuration) {
    double value = 1 / (videoDuration / translatedAudioDuration);
    double adjustedValue = max(0.5, min(value, 2.0));
    return adjustedValue.isNaN || adjustedValue == 0.0 ? 1.0 : adjustedValue;
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
