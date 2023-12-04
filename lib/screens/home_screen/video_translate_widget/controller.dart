import 'package:chewie/chewie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

final videoTranslateSProvider =
    Provider((ref) => VideoTranslateScreenController());

class VideoTranslateScreenController {
  var videoFile = StateProvider.autoDispose((ref) => "");
  var audioFile = StateProvider.autoDispose((ref) => "");
   late VideoPlayerController videoPlayerController;
   ChewieController? chewieController;



  }

