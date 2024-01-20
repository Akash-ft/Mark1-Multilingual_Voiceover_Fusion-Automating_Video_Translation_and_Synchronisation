import 'package:MVF/screens/home_screen/voice_translate_widget/state.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app_settings/app_enum.dart';
import '../../../app_settings/commons.dart';
import '../../../utils/reusable_widgets/alert_message.dart';
import 'controller.dart';

class VoiceTranslateWidget extends ConsumerStatefulWidget {
  const VoiceTranslateWidget({super.key});

  @override
  ConsumerState<VoiceTranslateWidget> createState() =>
      _VoiceTranslateWidgetState();
}

class _VoiceTranslateWidgetState extends ConsumerState<VoiceTranslateWidget> {
  @override
  Widget build(BuildContext context) {
    handleStateChange(ref, context);
    final state = ref.watch(voiceTranslateSProvider);
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
            child: state.audioFilePath != ""
                ? state.chewieAudioController != null
                    ? ChewieAudio(
                        controller: state.chewieAudioController!,
                      )
                    : Center(
                        child: Icon(
                          Icons.music_video,
                          size: 30,
                        ),
                      )
                : Center(
                    child: Icon(
                      Icons.music_off_outlined,
                      size: 30,
                    ),
                  )),
        SizedBox(
          height: 30.0,
        ),
        Icon(
          state.isRecording! ? Icons.mic : Icons.mic_off,
          size: 30,
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  ref.read(voiceTranslateSProvider.notifier).audioRecording(
                      recordingStateValues[RecordingState.Start]!);
                },
                child: Text("Start recording")),
            ElevatedButton(
                onPressed: () {
                  ref.read(voiceTranslateSProvider.notifier).audioRecording(
                      recordingStateValues[RecordingState.Stop]!);
                },
                child: Text("Stop recording"))
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              await ref.read(voiceTranslateSProvider.notifier).pickAudioFile(
                  targetedSourceValues[TargetedSourceType.gallery]!,
                  mediaFormatValues[MediaFormatType.audio]!);
            },
            child: Text("Upload a audio from storage")),
        IconButton(
            onPressed: () {
              ref
                  .read(voiceTranslateSProvider.notifier)
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
                //           .read(voiceTranslateSProvider.notifier)
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
                          .read(voiceTranslateSProvider.notifier)
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
                            'Selected Language: ${Commons.languages.firstWhere((lang) => lang['code'] == state.selectedLanguage)['name']}')
                        : Text('Select Language'),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (value) async {
                      if (value != null && value.isNotEmpty) {
                        ref
                            .read(voiceTranslateSProvider.notifier)
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
                              .read(voiceTranslateSProvider.notifier)
                              .readText(state.translatedText!,
                                  state.selectedLanguage!);
                        },
                        icon: Icon(Icons.play_circle, size: 50)),
                    IconButton(
                        onPressed: () async {
                          await ref
                              .read(voiceTranslateSProvider.notifier)
                              .saveSpeechAsAudioFile(state.translatedText!,
                                  state.selectedLanguage!);
                        },
                        icon: Icon(Icons.audio_file, size: 50)),
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
    ref.listen<VoiceTranslateScreenState>(voiceTranslateSProvider,
        (previous, next) {
      var control = ref.read(voiceTranslateSProvider.notifier);
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
