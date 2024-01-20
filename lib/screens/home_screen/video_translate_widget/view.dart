import 'package:MVF/app_settings/commons.dart';
import 'package:MVF/screens/home_screen/video_translate_widget/state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app_settings/app_enum.dart';
import '../../../utils/reusable_widgets/alert_message.dart';
import 'controller.dart';

class VideoTranslateWidget extends ConsumerStatefulWidget {
  const VideoTranslateWidget({super.key});

  @override
  ConsumerState<VideoTranslateWidget> createState() =>
      _VideoTranslateWidgetState();
}

class _VideoTranslateWidgetState extends ConsumerState<VideoTranslateWidget> {
  @override
  Widget build(BuildContext context) {
    handleStateChange(ref, context);
    final state = ref.watch(videoTranslateSProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30.0,
        ),
        Container(
            alignment: Alignment.topCenter,
            height: 200,
            width: 400,
            child: state.videoFilePath != ""
                ? state.chewieController != null
                    ? Chewie(
                        controller: state.chewieController!,
                      )
                    : Center(
                        child: Icon(
                          Icons.video_call,
                          size: 30,
                        ),
                      )
                : Center(
                    child: Icon(
                      Icons.videocam_off,
                      size: 30,
                    ),
                  )),
        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(videoTranslateSProvider.notifier)
                      .pickVideoFile(
                          targetedSourceValues[TargetedSourceType.gallery]!,
                          mediaFormatValues[MediaFormatType.video]!);
                  await ref
                      .read(videoTranslateSProvider.notifier)
                      .extractAudio();
                },
                child: Text("Upload  video  Gallery")),
            ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(videoTranslateSProvider.notifier)
                      .pickVideoFile(
                          targetedSourceValues[TargetedSourceType.camara]!,
                          mediaFormatValues[MediaFormatType.video]!);
                  await ref
                      .read(videoTranslateSProvider.notifier)
                      .extractAudio();
                },
                child: Text("Record  video on Camera")),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        IconButton(
            onPressed: () {
              ref
                  .read(videoTranslateSProvider.notifier)
                  .switchTab(state.tabIndex == 0 ? 1 : 0);
            },
            icon: Icon(
              Icons.swap_horizontal_circle,
              size: 30,
            )),
        SizedBox(
          height: 40.0,
        ),
        IndexedStack(
          index: state.tabIndex,
          children: [
            Container(
                child: Column(
              children: [
                // ElevatedButton(
                //     onPressed: () async {
                //       await ref
                //           .read(videoTranslateSProvider.notifier)
                //           .transcription();
                //     },
                //     child: Text("Transcript")),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: state.isLoadingTranscription == true
                        ? CircularProgressIndicator()
                        : state.transcriptedText == ""
                            ? Icon(
                                Icons.task_rounded,
                                size: 30,
                              )
                            : SingleChildScrollView(
                                child: Container(
                                    width: 400,
                                    child: Text(state.transcriptedText!)))),
                SizedBox(
                  height: 30,
                ),
                IconButton(
                    onPressed: () async {
                      await ref
                          .read(videoTranslateSProvider.notifier)
                          .readText(state.transcriptedText!, "en");
                    },
                    icon: Icon(Icons.play_circle, size: 50))
              ],
            )),
            Container(
                child: Column(
              children: [
                Container(
                  width: 250,
                  child: DropdownButton<String>(
                    itemHeight: 50,
                    menuMaxHeight: 300,
                    isDense: false,
                    isExpanded: true,
                    hint: state.selectedLanguage != null &&
                            state.selectedLanguage!.isNotEmpty
                        ? Text(
                            'Selected Language : ${Commons.languages.firstWhere((lang) => lang['code'] == state.selectedLanguage)['name']}')
                        : Text('Select Language'),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (value) async {
                      if (value != null && value.isNotEmpty) {
                        ref
                            .read(videoTranslateSProvider.notifier)
                            .setLanguage(value);
                      }
                    },
                    items: Commons.languages.map((language) {
                      return DropdownMenuItem<String>(
                        value: language['code']!.toString(),
                        child: Text(language['name']!.toString()),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: state.isLoadingTranslation == true
                        ? CircularProgressIndicator()
                        : state.translatedText == ""
                            ? Icon(
                                Icons.language,
                                size: 30,
                              )
                            : SingleChildScrollView(
                                child: Container(
                                    width: 400,
                                    child: Container(
                                        width: 400,
                                        child: Text(state.translatedText!))))),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await ref
                              .read(videoTranslateSProvider.notifier)
                              .readText(state.translatedText!,
                                  state.selectedLanguage!);
                        },
                        icon: Icon(Icons.play_circle, size: 50)),
                    IconButton(
                        onPressed: () async {
                          await ref
                              .read(videoTranslateSProvider.notifier)
                              .saveSpeechAsAudioFile(state.translatedText!,
                                  state.selectedLanguage!);
                        },
                        icon: Icon(Icons.audio_file, size: 50)),
                    IconButton(
                        onPressed: () async {
                          await ref
                              .read(videoTranslateSProvider.notifier)
                              .generateVoiceOverForVideo();
                        },
                        icon: Icon(Icons.video_camera_back_outlined, size: 50)),
                  ],
                )
              ],
            ))
          ],
        )
      ],
    );
  }

  void handleStateChange(
    WidgetRef ref,
    BuildContext context,
  ) {
    ref.listen<VideoTranslateScreenState>(videoTranslateSProvider,
        (previous, next) {
      var control = ref.read(videoTranslateSProvider.notifier);
      if (next.showAlertMessage == true) {
        showMessageDialog(
            context: context,
            title: next.messageTitle!,
            message: next.message!,
            onOkPressed: () => control.hideAlertMessage());
      }
    });
  }
}
