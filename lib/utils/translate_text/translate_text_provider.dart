import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translator/translator.dart';

final translateTextProvider = Provider((ref) => TranslateText());

class TranslateText {
  Future<String> translateText(String text, String targetLanguage) async {
    GoogleTranslator translator = GoogleTranslator();
    Translation translation =
        await translator.translate(text, to: targetLanguage);
    print(translation.text);
    return translation.text;
  }
}
