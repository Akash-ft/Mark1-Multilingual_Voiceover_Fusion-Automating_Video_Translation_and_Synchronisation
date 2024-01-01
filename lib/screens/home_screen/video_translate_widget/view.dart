import 'package:b_native/screens/home_screen/video_translate_widget/state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    // final cController = ref.watch(videoTranslateSProvider).chewieController;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        state.videoFilePath != ""
            ? state.chewieController != null
                ? Container(
                    height: 200,
                    width: 400,
                    child: Chewie(
                      controller: state.chewieController!,
                    ))
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
              ),
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
                      .pickVideoFile(1, 1);
                  await ref
                      .read(videoTranslateSProvider.notifier)
                      .extractAudio(state.videoFilePath!);
                },
                child: Text("Upload  video  Gallery")),
            ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(videoTranslateSProvider.notifier)
                      .pickVideoFile(2, 1);
                  await ref
                      .read(videoTranslateSProvider.notifier)
                      .extractAudio(state.videoFilePath!);
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
                  .swtichTab(state.tabIndex == 0 ? 1 : 0);
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
                ElevatedButton(
                    onPressed: () async {
                      await ref
                          .read(videoTranslateSProvider.notifier)
                          .transcription();
                    },
                    child: Text("Transcript")),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: state.isLoadingTranscription == true
                        ? CircularProgressIndicator()
                        : state.translatedText == ""
                            ? Icon(
                                Icons.task_rounded,
                                size: 30,
                              )
                            : SingleChildScrollView(
                                child: Text(state.transcriptedText!))),
              ],
            )),
            Container(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      hint: state.selectedLanguage != null &&
                              state.selectedLanguage!.isNotEmpty
                          ? Text(
                              'Selected Language: ${state.selectedLanguage!}')
                          : Text('Select Language'),
                      //value: state.selectedLanguage,
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (value) async {
                        if (value != null && value.isNotEmpty) {
                          ref
                              .read(videoTranslateSProvider.notifier)
                              .setLanguage(value!);
                        }
                        ;
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'es', // Spanish
                          child: Text('Spanish'),
                        ),
                        DropdownMenuItem(
                          value: 'fr', // French
                          child: Text('French'),
                        ),
                        DropdownMenuItem(
                          value: 'ta', // Tamil
                          child: Text('Tamil'),
                        ),
                        DropdownMenuItem(
                          value: 'de', // German
                          child: Text('German'),
                        ),
                        DropdownMenuItem(
                          value: 'ja', // Japanese
                          child: Text('Japanese'),
                        ),
                        DropdownMenuItem(
                          value: 'ko', // Korean
                          child: Text('Korean'),
                        ),
                        DropdownMenuItem(
                          value: 'zh', // Chinese
                          child: Text('Chinese'),
                        ),
                        DropdownMenuItem(
                          value: 'hi', // Hindi
                          child: Text('Hindi'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(videoTranslateSProvider.notifier)
                              .translation();
                        },
                        child: Text("Translate")),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: state.isLoadingTranscription == true
                        ? CircularProgressIndicator()
                        : state.translatedText == ""
                            ? Icon(
                                Icons.language,
                                size: 30,
                              )
                            : SingleChildScrollView(
                                child: Text(state.translatedText!))),
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
    var control = ref.read(videoTranslateSProvider.notifier);
    ref.listen<VideoTranslateScreenState>(videoTranslateSProvider,
        (previous, next) {
      if (next.isSuccess!) {
        // showMessageDialog(
        //   isCancellable: false,
        //   context: context,
        //   title: "Success",
        //   message: 'Details has been updated',
        // );
        control.initializeVideoPlayer(next.videoFilePath!);
      }
      // else {
      //   if (next.message != null) {
      //     showMessageDialog(
      //         context: context, title: "Error", message: next.message!);
      //   }
      // }
    });
  }
}
