import 'package:hooks_riverpod/hooks_riverpod.dart';

final videoTranslateSProvider = Provider((ref) => VideoTranslateScreenController());

class VideoTranslateScreenController {
  var videoFile= StateProvider.autoDispose((ref) => "");
  var audioFile= StateProvider.autoDispose((ref) => "");
}