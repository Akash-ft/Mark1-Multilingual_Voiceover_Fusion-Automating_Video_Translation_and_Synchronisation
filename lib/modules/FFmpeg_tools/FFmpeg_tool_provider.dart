import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final FFmpegToolProvider = Provider((ref) => FFmpegTools());

class FFmpegTools {

  Future<String> extractAudioFromVideo(String videoFile) async {
    try {
      ReturnCode? returnCode;
      DateTime now = DateTime.now();
      String timestamp = now.toIso8601String().replaceAll(RegExp(r'[:.]'), '_');
      String filePath = '/sdcard/Download/outputAudio_$timestamp.wav';
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

  Future<double> getMediaDuration(String filePath) async {
    try {
      final mediaInfoSession = await FFprobeKit.getMediaInformation(filePath);
      await Future.delayed(Duration(seconds: 1));
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
      DateTime now = DateTime.now();
      String timestamp = now.toIso8601String().replaceAll(RegExp(r'[:.]'), '_');
      String outputFilePath = '/sdcard/Download/outputVideo_$timestamp.mp4';
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

  Future<String> mergeAudioInVideo(String videoFile, String audioFilePath) async {
    try {
      ReturnCode? returnCode;
      DateTime now = DateTime.now();
      String timestamp = now.toIso8601String().replaceAll(RegExp(r'[:.]'), '_');
      String outputFilePath = '/sdcard/Download/mergedVideo_$timestamp.mp4';
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

  Future<String> adjustAudioSpeed(String audioFile, double playbackSpeed) async {
    try {
      ReturnCode? returnCode;
      DateTime now = DateTime.now();
      String timestamp = now.toIso8601String().replaceAll(RegExp(r'[:.]'), '_');
      String outputFilePath = '/sdcard/Download/adjustAudioSpeed_$timestamp.wav';
      double roundedValue = double.parse(playbackSpeed.toStringAsFixed(1));
      String command = '-i $audioFile -filter:a "atempo=$roundedValue" $outputFilePath';

      final session = await FFmpegKit.execute(command);
      returnCode = await session.getReturnCode();

      print('FFmpeg command Remove and Adjust Audio Speed ${await session.getState()} and Code $returnCode');

      if (returnCode!.getValue() == ReturnCode.success) {
        print('Adjust Audio Speed file exists: $outputFilePath');
        return outputFilePath;
      } else {
        var outPut = await File(outputFilePath).exists() ? outputFilePath : '';
        print('Adjust Audio Speed file else block $outPut.');
        return outPut;
      }
    } catch (e) {
      print('Adjust Audio Speed: $e');
      return '';
    }
  }
}
