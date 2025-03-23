import 'dart:convert';
import 'dart:io';
import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app_settings/app_key.dart';
import 'model/transcription_result.dart';
import "package:http_parser/http_parser.dart" show MediaType;


final transcribeAudioProvider = Provider((ref) => TranscribeAudio());

class TranscribeAudio {
  // void _initializeOpenAI() {
  //   OpenAI.apiKey = Token().openAiApiKey;
  // }

  Deepgram _initializeDeepSpeech() {
    final apiKey = Token().deepSpeechApiKey;
    Deepgram deepgram = Deepgram(apiKey, baseQueryParams: {
      'model': 'whisper',
      'detect_language': true,
    });
    return deepgram;
  }

  // Future<String> transcribeAudio(String audioFile) async {
  //   try {
  //     _initializeOpenAI();
  //     File audioFilePath = File(audioFile);
  //     print("Transcribe Audio Ai path ${audioFilePath}");
  //     OpenAIAudioModel transcription =
  //         await OpenAI.instance.audio.createTranslation(
  //       file: audioFilePath,
  //       model: "whisper-1",
  //       responseFormat: OpenAIAudioResponseFormat.json,
  //     );
  //     return transcription.text;
  //   } catch (e) {
  //     print("Error Transcribe Audio Ai: $e");
  //     return "";
  //   }
  // }

  Future<TranscriptionResult?> transcribeAudio(String audioFile) async {
    try {
      Deepgram deepgram = _initializeDeepSpeech();
      File audioFilePath = File(audioFile);
      print("Transcribe Audio AI path $audioFilePath");

      // Get response from Deepgram
      dynamic res = await deepgram.transcribeFromFile(audioFilePath);

      // Check if the response is a string and decode it
      if (res != null && res is String) {
        Map<String, dynamic> jsonData = json.decode(res);

        // Safely access the nested fields
        if (jsonData['results'] != null &&
            jsonData['results']['channels'] != null &&
            jsonData['results']['channels'][0]['alternatives'] != null) {
          Map<String, dynamic> alternativeData =
              jsonData['results']['channels'][0]['alternatives'][0];
          TranscriptionResult result =
              TranscriptionResult.fromJson(alternativeData);
          return result;
        } else {
          print("No valid transcription results found.");
          return null;
        }
      } else {
        print("Invalid response format.");
        return null;
      }
    } catch (e) {
      print("Error Transcribe Audio AI: $e");
      return null;
    }
  }

  Future<TranscriptionResult?> transcribeAudioV1(String audioFile) async {
    try {
      // API Endpoint
      String url = "https://api.deepgram.com/v1/listen?model=whisper";

      // API Token (Replace with your actual token)
      String apiKey = "0c19b57fb68e6225b705c779d869ab6bfe28fa19";

      // Read the audio file as bytes
      File audioFilePath = File(audioFile);
      if (!audioFilePath.existsSync()) {
        print("File does not exist at path: $audioFile");
        return null;
      }

      List<int> audioBytes = await audioFilePath.readAsBytes();

      // Prepare request headers
      var headers = {
        "Authorization": "Token $apiKey",
        "Content-Type": "audio/wav", // Correct content type
      };

      // Send POST request with audio bytes as binary data
      var response = await Dio().post(
        url,
        data: Stream.fromIterable([audioBytes]),
        options: Options(
          headers: headers,
          contentType: 'audio/wav',
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // Decode JSON response
        Map<String, dynamic> jsonData = response.data;

        // Check if transcription results are available
        if (jsonData['results'] != null &&
            jsonData['results']['channels'] != null &&
            jsonData['results']['channels'][0]['alternatives'] != null) {
          Map<String, dynamic> alternativeData =
          jsonData['results']['channels'][0]['alternatives'][0];

          // Parse the response into TranscriptionResult model
          TranscriptionResult result = TranscriptionResult.fromJson(alternativeData);
          return result;
        } else {
          print("No valid transcription results found.");
          return null;
        }
      } else {
        print("Error: ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error Transcribe Audio AI: $e");
      return null;
    }
  }



}
