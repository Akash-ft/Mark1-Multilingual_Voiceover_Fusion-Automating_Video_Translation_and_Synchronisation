import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final FFmpegToolProvider = Provider((ref) => FFmpegTools());

class FFmpegTools {
  Future<String> extractAudioFromVideo(String videoFile) async {
    try {
      ReturnCode? returnCode;
      String fileExtension = 'wav';
      String fileName = 'outputAudio.$fileExtension';
      String filePath = '/sdcard/Download/$fileName';
      Directory appDocDir = await getApplicationDocumentsDirectory();
      // '${appDocDir.path}/output.wav';
      print("extracted path  ${filePath}");
      String command = '-i $videoFile -vn $filePath';
      final session = await FFmpegKit.execute(command);
      returnCode = await session.getReturnCode();
      print(
          'FFmpeg command Extract Audio From Video ${await session.getState()} and Code $returnCode');
      if (returnCode!.getValue() == ReturnCode.success) {
        print('Output of Extract Audio From Video file exists: $filePath');
        return filePath;
      } else {
        var outPut = await File(filePath).exists() ? filePath : '';
        print('Output of Remove Audio From Video file else block $outPut.');
        return outPut;
      }
    } catch (e) {
      print('Error Extract Audio From Video: $e');
      return '';
    }
  }

  Future<double?> getMediaDuration(String filePath) async {
    try {
      final mediaInfoSession = await FFprobeKit.getMediaInformation(filePath);
      final mediaInfo = mediaInfoSession.getMediaInformation()!;
      final duration = double.parse(mediaInfo.getDuration()!);
      print('Duration audio file: $duration');
      return duration;
    } catch (e) {
      print('Error getting media duration: $e');
      return 0.0;
    }
  }

  Future<String> removeAudioFromVideo(String videoFile) async {
    try {
      ReturnCode? returnCode;
      String outputFilePath = '/sdcard/Download/outputVideo.mp4';
      String command = '-i $videoFile -c copy -an $outputFilePath';
      final session = await FFmpegKit.execute(command);
      returnCode = await session.getReturnCode();
      print(
          'FFmpeg command Remove Audio From Video ${await session.getState()} and Code $returnCode');
      if (returnCode!.getValue() == ReturnCode.success) {
        print('Output of Remove Audio From Video file exists: $outputFilePath');
        return outputFilePath;
      } else {
        var outPut = await File(outputFilePath).exists() ? outputFilePath : '';
        print('Output of Remove Audio From Video file else block $outPut.');
        return outPut;
      }
    } catch (e) {
      print('Error Remove Audio From Video: $e');
      return '';
    }
  }

  Future<String> mergeAudioInVideo(
      String videoFile, String audioFilePath) async {
    try {
      ReturnCode? returnCode;
      String outputFilePath = '/sdcard/Download/mergedVideo.mp4';
      String command =
          '-i $videoFile -i $audioFilePath -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0 $outputFilePath';
      final session = await FFmpegKit.execute(command);
      returnCode = await session.getReturnCode();
      print(
          'FFmpeg command Merge Audio In Video  ${await session.getState()} and Code $returnCode');
      if (returnCode!.getValue() == ReturnCode.success) {
        print('Output of Merge Audio In Video file exists: $outputFilePath');
        return outputFilePath;
      } else {
        var outPut = await File(outputFilePath).exists() ? outputFilePath : '';
        print('Output of Merge Audio In Video file else block $outPut');
        return outPut;
      }
    } catch (e) {
      print('Error Merge Audio In Video: $e');
      return '';
    }
  }
}
