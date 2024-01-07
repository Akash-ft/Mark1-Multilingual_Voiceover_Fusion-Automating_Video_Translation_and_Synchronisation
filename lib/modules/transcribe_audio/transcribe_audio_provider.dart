import 'dart:io';
import 'package:b_native/app_settings/app_key.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dart_openai/dart_openai.dart';

final transcribeAudioProvider = Provider((ref) => TranscribeAudio());

class TranscribeAudio {
  void _initializeOpenAI() {
    OpenAI.apiKey = Token().openAiApiKey;
  }

  Future<String> transcribeAudio(String audioFile) async {
    try {
      _initializeOpenAI();
      File audioFilePath = File(audioFile);
      print("Transcribe Audio Ai path ${audioFilePath}");
      OpenAIAudioModel transcription =
          await OpenAI.instance.audio.createTranslation(
        file: audioFilePath,
        model: "whisper-1",
        responseFormat: OpenAIAudioResponseFormat.json,
      );
      return transcription.text;
    } catch (e) {
      print("Error Transcribe Audio Ai: $e");
      return "";
    }
  }
}
