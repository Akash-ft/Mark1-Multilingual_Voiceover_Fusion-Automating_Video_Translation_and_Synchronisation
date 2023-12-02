import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageTranslateSProvider = Provider((ref) => ImageTranslateScreenController());

class ImageTranslateScreenController {
  var imageFile= StateProvider.autoDispose((ref) => "");
}