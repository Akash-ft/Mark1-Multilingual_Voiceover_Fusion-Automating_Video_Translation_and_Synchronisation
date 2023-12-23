import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final FFmpegToolProvider = Provider((ref) => FFmpegTools());

class FFmpegTools {
  Future<String> extractAudioFromVideo(File videoFile) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String outputPath = '/sdcard/Download/output.wav';
          // '${appDocDir.path}/output.wav';
      print("extracted path  ${outputPath}");
      String command = '-i ${videoFile.path} -vn $outputPath';
      FFmpegKit.executeAsync(command, (session) async {
        final returnCode = await session.getReturnCode();
        print('FFmpeg command ${await session.getState()} and code $returnCode');
      });
      File outputFile = File(outputPath);
      if (await outputFile.exists()) {
        print('Output audio file exists: ${outputFile.path}');
        return outputFile.path;
      } else {
        print('Output audio file does not exist.');
        return '';
      }
    } catch (e) {
      print('Error extracting audio: $e');
      return '';
    }
  }
}
