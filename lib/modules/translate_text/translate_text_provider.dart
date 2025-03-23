import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translator/translator.dart';
import '../../app_settings/app_key.dart';

final translateTextProvider = Provider((ref) => TranslateText());

class TranslateText {
  Dio client = Dio();

  Future<String> translateTextV1(String text, String targetLanguage) async {
    try {
      GoogleTranslator translator = GoogleTranslator();
      Translation translation =
          await translator.translate(text, to: targetLanguage);
      print(translation.text);
      return translation.text;
    } catch (e) {
      print('Error Translation API V1: $e');
      return '';
    }
  }

  Future<String> translateTextV2(String text, String targetLanguage) async {

    try {
      String translatedText="";
      const String apiUrl =
          'https://translation.googleapis.com/language/translate/v2';
      Map<String, dynamic> payload = {
        'q': text,
        'target': targetLanguage,
      };
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'X-goog-api-key': Token().googleApiKey,
      };

      final response = await client.post(
        apiUrl,data: payload,options: Options(headers: headers)
      );

      if (response.statusCode == 200) {
        print(response.data);
        final Map<String,dynamic> data = response.data;
        translatedText =data['data']['translations'][0]['translatedText'];
        return translatedText;
      } else {
        print('Google Translate API Error: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error Translation API V2: $e');
      return '';
    }
  }
}
