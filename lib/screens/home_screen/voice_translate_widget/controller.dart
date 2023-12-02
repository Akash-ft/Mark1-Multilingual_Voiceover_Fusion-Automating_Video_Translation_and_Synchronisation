import 'package:hooks_riverpod/hooks_riverpod.dart';

final audioTranslateSProvider = Provider((ref) => AudioTranslateScreenController());

class AudioTranslateScreenController {
  var audioFile= StateProvider.autoDispose((ref) => "");
}