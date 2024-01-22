import 'dart:io';
import 'package:MVF/modules/audio_recorder/audio_recorder_provider.dart';
import 'package:MVF/screens/home_screen/voice_translate_widget/state.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../app_settings/app_enum.dart';
import '../../../modules/text_2_speech/tts_provider.dart';
import '../../../modules/transcribe_audio/transcribe_audio_provider.dart';
import '../../../modules/translate_text/translate_text_provider.dart';
import '../../../utils/upload_file/upload_file_provider.dart';

final voiceTranslateSProvider = StateNotifierProvider.autoDispose<
        VoiceTranslateScreenController, VoiceTranslateScreenState>(
    (ref) => VoiceTranslateScreenController(
        ref.read(uploadFileProvider),
        ref.read(transcribeAudioProvider),
        ref.read(translateTextProvider),
        ref.read(Text2SpeechProvider),
        ref.read(VoiceRecordProvider)));

class VoiceTranslateScreenController
    extends StateNotifier<VoiceTranslateScreenState> {
  VoiceTranslateScreenController(this.uploadFile, this.transcriptAudio,
      this.translateText, this.text2speech, this.voiceRecord)
      : super(VoiceTranslateScreenState.empty());
  UploadFile uploadFile;
  TranscribeAudio transcriptAudio;
  TranslateText translateText;
  Text2Speech text2speech;
  VoiceRecorder voiceRecord;

  void audioRecording(int status) async {
    String file = '/sdcard/Download/audio_recording.wav';
    if (status == recordingStateValues[RecordingState.Start]) {
      state = state.copyWith(isRecording: true);
      voiceRecord.startRecording(file);
      state = state.copyWith(audioFilePath: file);
    } else if (status == recordingStateValues[RecordingState.Stop]) {
      voiceRecord.stopRecording();
      state = state.copyWith(isRecording: false);
      await initializeAudioPlayer(file);
    }
  }

  Future<void> initializeAudioPlayer(String filePath) async {
    File file = File(filePath);
    print("video player initializes");
    final videoPlayerController = VideoPlayerController.file(file);
    await videoPlayerController.initialize();
    state = state.copyWith(
      audioFilePath: filePath,
      videoPlayerController: videoPlayerController,
      chewieAudioController: ChewieAudioController(
        videoPlayerController: videoPlayerController,
      ),
    );
    await transcription();
  }

  Future<void> pickAudioFile(int target, int format) async {
    var file = await uploadFile.pickFileData(target, format);
    print("File path ${file.path}");
    if (file.path != "") {
      await initializeAudioPlayer(file.path);
    }
  }

  Future<void> transcription() async {
    if (state.audioFilePath != "") {
      state = state.copyWith(isLoadingTranscription: true);
      //COMMENTED FOR TESTING PURPOSE
      var transcriptedContent =
          await transcriptAudio.transcribeAudio(state.audioFilePath!);
      // await Future.delayed(Duration(seconds: 1));
      // var transcriptedContent =
      //     "Excellence is never an accident. It is always the result of high intention, sincere effort, and intelligent execution. It represents the wise choice of many alternatives. Choice, not chance, determines your destiny.";
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

  Future<void> saveSpeechAsAudioFile(String text, String langCode) async {
    var translatedAudioFile =
        await text2speech.saveSpeechToFile(text, langCode);
    if (translatedAudioFile != "") {
      state = state.copyWith(translatedAudioFilePath: translatedAudioFile);
      await initializeAudioPlayer(translatedAudioFile);
      state = state.copyWith(
          showAlertMessage: true,
          message: "Translated audio is loaded in the player",
          messageTitle: "Success-GenerateVoiceOverForAudio");
    } else {
      print("Translated Audio file path is missing for transcription");
      state = state.copyWith(
          showAlertMessage: true,
          message: "Failed to save the Speech file",
          messageTitle: "Error-SaveSpeechAsAudioFile");
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

  Future<void> openVoiceRecorder() async {}

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
