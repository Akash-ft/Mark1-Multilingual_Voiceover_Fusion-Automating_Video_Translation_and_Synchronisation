import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

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
    String fileExtension = 'wav';
    String fileName = 'outputTranslatedAudio.$fileExtension';
    String filePath = '/sdcard/Download/$fileName';
    Directory appDocDir = await getApplicationDocumentsDirectory();
    int result = await flutterTts.synthesizeToFile(transcript, filePath);
    if (result == 1) {
      audioFilePath = filePath;
      print('File saved at: $audioFilePath');
    } else {
      print('Failed to save file');
    }
    return audioFilePath;
  }

  Future<String> saveSyncSpeechToFile(String transcript, String languageCode,
      double videoDuration, double translatedAudioDuration) async {
    String audioFilePath = "";
    double adjustedSpeechRate = videoDuration / translatedAudioDuration;
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setSpeechRate(adjustedSpeechRate);
    String fileExtension = 'wav';
    String fileName = 'outputSyncTranslatedAudio.$fileExtension';
    String filePath = '/sdcard/Download/$fileName';
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    int result = await flutterTts.synthesizeToFile(transcript, filePath);
    if (result == 1) {
      audioFilePath = filePath;
      print('Synced File saved at: $audioFilePath');
    } else {
      print('Failed to Synced save file');
    }
    return audioFilePath;
  }
}
