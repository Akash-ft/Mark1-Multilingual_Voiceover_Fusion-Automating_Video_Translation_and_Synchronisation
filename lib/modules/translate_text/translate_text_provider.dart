import 'dart:convert';

import 'package:b_native/app_settings/app_key.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translator/translator.dart';

final translateTextProvider = Provider((ref) => TranslateText());

class TranslateText {
  Dio client = Dio();

  Future<String> translateTextV1(String text, String targetLanguage) async {
    try{
    GoogleTranslator translator = GoogleTranslator();
    Translation translation =
        await translator.translate(text, to: targetLanguage);
    print(translation.text);
    return translation.text;
    }
    catch(e){
      print('Error Translation API V1: $e');
      return '';
    }
  }

  Future<String> translateTextV2(String text, String targetLanguage) async {
    try {
      final String apiUrl =
          'https://translation.googleapis.com/language/translate/v2';
      Map<String, dynamic> payload = {
        'q': text,
        'target': targetLanguage,
        'key': Token().googleApiKey,
      };
      final response = await client.post(apiUrl, data: payload);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.toString());
        return data['data']['translations'][0]['translatedText'];
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
