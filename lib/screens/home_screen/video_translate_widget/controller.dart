import 'dart:io';
import 'package:b_native/screens/home_screen/video_translate_widget/state.dart';
import 'package:chewie/chewie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../utils/FFmpeg_tools/FFmpeg_tool_provider.dart';
import '../../../utils/transcribe_audio/transcribe_audio_provider.dart';
import '../../../utils/translate_text/translate_text_provider.dart';
import '../../../utils/upload_file/upload_file_provider.dart';

final videoTranslateSProvider = StateNotifierProvider.autoDispose<
        VideoTranslateScreenController, VideoTranslateScreenState>(
    (ref) => VideoTranslateScreenController(
          ref.read(uploadFileProvider),
          ref.read(FFmpegToolProvider),
          ref.read(transcribeAudioProvider),
          ref.read(translateTextProvider),
        ));

class VideoTranslateScreenController
    extends StateNotifier<VideoTranslateScreenState> {
  VideoTranslateScreenController(this.uploadFile, this.ffmpegTools,
      this.transcriptAudio, this.translateText)
      : super(VideoTranslateScreenState.empty());
  UploadFile uploadFile;
  FFmpegTools ffmpegTools;
  TranscribeAudio transcriptAudio;
  TranslateText translateText;

  Future<void> pickVideoFile(int target, int format) async {
    var file = await uploadFile.pickFileData(target, format);
    print("File path ${file.path}");
    if (file.path != "") {
      state = state.copyWith(
        videoFilePath: file.path,
        isSuccess: true,
      );
    }
  }

  Future<void> extractAudio(String videoFile) async {
    File vFile = File(state.videoFilePath!);
    var file = await ffmpegTools.extractAudioFromVideo(vFile);
    print("extract audio file path ${file}");
    if (file != "") {
      state = state.copyWith(audioFilePath: file, isSuccess: true);
    }
  }

  Future<void> initializeVideoPlayer(String fileName) async {
    File file = File(fileName);
    print("video player initializes");
    final videoPlayerController = VideoPlayerController.file(file);
    await videoPlayerController.initialize();
    state = state.copyWith(
      videoPlayerController: videoPlayerController,
      chewieController: ChewieController(
        videoPlayerController: videoPlayerController,
      ),
    );
  }

  Future<void> transcription() async {
    if (state.audioFilePath != "") {
      try {
        state = state.copyWith(isLoadingTranscription: true);
        var transcriptedContent =
        await transcriptAudio.transcribeAudio(state.audioFilePath!);
        print("transcription ${transcriptedContent}");
        state = state.copyWith(
            transcriptedText: transcriptedContent,
            isSuccess: true,
            isLoadingTranscription: false);
      } catch (e) {
        state = state.copyWith(isLoadingTranscription: false);
        // Handle error if necessary
      }
    }
  }

  Future<void> translation() async {
    if (state.transcriptedText != "" && state.selectedLanguage != "") {
      try {
        state = state.copyWith(isLoadingTranslation: true);
        var translatedContent = await translateText.translateText(
            state.transcriptedText!, state.selectedLanguage!);
        state = state.copyWith(
            translatedText: translatedContent,
            isSuccess: true,
            isLoadingTranslation: false);
      } catch (e) {
        state = state.copyWith(isLoadingTranslation: false);
        // Handle error if necessary
      }
    }
  }

  void setLanguage(String languageCode) {
    state = state.copyWith(selectedLanguage: languageCode);
  }

  void swtichTab(int tabIndex) {
    state = state.copyWith(tabIndex: tabIndex);
  }
}
