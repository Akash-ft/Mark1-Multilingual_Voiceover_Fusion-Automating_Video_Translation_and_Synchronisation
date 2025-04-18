import 'package:MVF/screens/home_screen/voice_translate_widget/state.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
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
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              _buildAudioPlayer(state),
              SizedBox(
                height: 30.0,
              ),
              _buildAudioControlButtons(ref, context),
              SizedBox(
                height: 30.0,
              ),
              _buildTabView(state, ref),
            ],
          ),
        ),
        if (state.mainScreenLoader == true)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF16F5D3))),
            ),
          ),
      ],
    );
  }

  // ===========================
  //  Handle State Change
  // ===========================
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

  // ===========================
  //  Build Audio Player
  // ===========================
  Widget _buildAudioPlayer(VoiceTranslateScreenState state) {
    return Container(
      alignment: Alignment.topCenter,
      height: 200,
      width: 400,
      child: state.audioFilePath != ""
          ? state.chewieAudioController != null
          ? ChewieAudio(
        controller: state.chewieAudioController!,
      )
          : Center(
        child: Icon(Icons.music_video,
            size: 30, color: Color(0xFF2F455C)),
      )
          : Center(
        child: Icon(Icons.music_off_outlined,
            size: 30, color: Color(0xFF2F455C)),
      ),
    );
  }

  // ===========================
  //  Build Audio Control Buttons
  // ===========================
  Widget _buildAudioControlButtons(WidgetRef ref, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButton(
            ref,
            icon: Icons.file_upload_outlined,
            label: "Upload audio",
            onPressed: () async {
              await ref
                  .read(voiceTranslateSProvider.notifier)
                  .pickAudioFile(
                  targetedSourceValues[TargetedSourceType.gallery]!,
                  mediaFormatValues[MediaFormatType.audio]!);
            },
          ),
          SizedBox(
            width: 30,
          ),
          _buildButton(
            ref,
            icon: Icons.mic_none_outlined,
            label: "Record audio",
            onPressed: () => _showRecordingDialog(ref, context),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      WidgetRef ref, {
        required IconData icon,
        required String label,
        required VoidCallback onPressed,
      }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2F455C)),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: 5,
          ),
          Text(label,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand')),
        ],
      ),
    );
  }

  // ===========================
  //  Show Recording Dialog
  // ===========================
  void _showRecordingDialog(WidgetRef ref, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, ref, child) => AlertDialog(
              title: Text(
                'Voice Recorder',
                style: TextStyle(
                    color: Color(0xFF2F455C),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
              content: Icon(
                ref.watch(voiceTranslateSProvider).isRecording!
                    ? Icons.mic
                    : Icons.mic_off,
                size: 30,
                color: Color(0xFF2F455C),
              ),
              actions: [
                _buildRecordingButton(ref, "Start recording",
                    Icons.not_started_outlined, RecordingState.Start),
                _buildRecordingButton(ref, "Stop recording",
                    Icons.stop_circle_outlined, RecordingState.Stop,
                    closeDialog: true),
              ],
            ),
          );
        });
  }

  Widget _buildRecordingButton(
      WidgetRef ref,
      String label,
      IconData icon,
      RecordingState state, {
        bool closeDialog = false,
      }) {
    return ElevatedButton(
      onPressed: () {
        ref
            .read(voiceTranslateSProvider.notifier)
            .audioRecording(recordingStateValues[state]!);
        if (closeDialog) Navigator.of(context).pop();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Color(0xFF2F455C),
            size: 30,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(
                color: Color(0xFF2F455C),
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand'),
          ),
        ],
      ),
    );
  }

  // ===========================
  //  Build Tab View
  // ===========================
  Widget _buildTabView(VoiceTranslateScreenState state, WidgetRef ref) {
    return Container(
      width: 1000,
      height: 450,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ButtonsTabBar(
              backgroundColor: Color(0xFF21D0B2),
              unselectedBackgroundColor: Color(0xFF2F455C),
              unselectedLabelStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.transcribe_outlined),
                  text: "Transcription",
                ),
                Tab(
                  icon: Icon(Icons.translate_outlined),
                  text: "Translation",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildTranscriptionTab(state, ref),
                  _buildTranslationTab(state, ref),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================
  //  Build Transcription Tab
  // ===========================
  Widget _buildTranscriptionTab(
      VoiceTranslateScreenState state, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 500,
              height: 270,
              child: Center(
                child: state.isLoadingTranscription == true
                    ? CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Color(0xFF16F5D3)),
                )
                    : (state.transcriptedResult == null ||
                    state.transcriptedResult!.transcript.isEmpty)
                    ? Icon(
                  Icons.task_rounded,
                  size: 30,
                  color: Color(0xFF2F455C),
                )
                    : SingleChildScrollView(
                  child: Container(
                    width: 400,
                    child: Text(state.transcriptedResult!.transcript),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () async {
                if (state.transcriptedResult != null &&
                    state.transcriptedResult!.transcript.isNotEmpty) {
                  await ref
                      .read(voiceTranslateSProvider.notifier)
                      .readText(state.transcriptedResult!.transcript, "en");
                } else {
                  print("No transcript available to read");
                }
              },
              icon: Icon(Icons.play_circle, size: 50, color: Color(0xFF21D0B2)),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================
  //  Build Translation Tab
  // ===========================
  Widget _buildTranslationTab(
      VoiceTranslateScreenState state, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Language :',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2F455C),
                ),
              ),
              SizedBox(width: 25),
              Container(
                width: 100,
                child: DropdownButton<String>(
                  itemHeight: 50,
                  menuMaxHeight: 250,
                  isDense: false,
                  isExpanded: true,
                  hint: state.selectedLanguage != null &&
                      state.selectedLanguage!.isNotEmpty
                      ? Text(
                    Commons.languages.firstWhere(
                            (lang) =>
                        lang['code'] == state.selectedLanguage)[
                    'name']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2F455C),
                    ),
                  )
                      : Text(''),
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
                      child: Text(
                        language['name']!.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2F455C),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 500,
            height: 190,
            child: Center(
                child: state.isLoadingTranslation == true
                    ? CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xFF16F5D3)))
                    : state.translatedText == ""
                    ? Icon(
                  Icons.language,
                  size: 30,
                  color: Color(0xFF2F455C),
                )
                    : SingleChildScrollView(
                  child: Container(
                      width: 400, child: Text(state.translatedText!)),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  await ref
                      .read(voiceTranslateSProvider.notifier)
                      .readText(state.translatedText!, state.selectedLanguage!);
                },
                icon: Icon(
                  Icons.play_circle,
                  size: 50,
                  color: Color(0xFF21D0B2),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await ref
                      .read(voiceTranslateSProvider.notifier)
                      .saveSpeechAsAudioFile(
                      state.translatedText!, state.selectedLanguage!);
                },
                icon: Icon(
                  Icons.audio_file,
                  size: 50,
                  color: Color(0xFF21D0B2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
