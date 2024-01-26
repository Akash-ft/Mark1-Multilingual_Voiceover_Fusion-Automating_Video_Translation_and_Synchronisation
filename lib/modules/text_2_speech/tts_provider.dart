import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Text2SpeechProvider = Provider((ref) => Text2Speech());

class Text2Speech {
  FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String transcript, String languageCode) async {
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setSpeechRate(0.50);
    await flutterTts.speak(transcript);
  }

  Future<String> saveSpeechToFile(
      String transcript, String languageCode) async {
    String audioFilePath = "";
    await flutterTts.setLanguage(languageCode);
    DateTime now = DateTime.now();
    String timestamp = now.toIso8601String().replaceAll(RegExp(r'[:.]'), '_');
    String filePath = '/sdcard/Download/outputTranslatedAudio_$timestamp.wav';
    int result = await flutterTts.synthesizeToFile(transcript, filePath);
    if (result == 1) {
      audioFilePath = filePath;
      print('File saved at: $audioFilePath');
    } else {
      print('Failed to save file');
    }
    return audioFilePath;
  }

}
