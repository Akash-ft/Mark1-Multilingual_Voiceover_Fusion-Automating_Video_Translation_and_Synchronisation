import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../utils/upload_file/upload_file_provider.dart';
import 'controller.dart';

class AudioTranslateWidget extends ConsumerStatefulWidget {
  const AudioTranslateWidget({super.key});

  @override
  ConsumerState<AudioTranslateWidget> createState() =>
      _AudioTranslateWidgetState();
}

class _AudioTranslateWidgetState extends ConsumerState<AudioTranslateWidget> {
  late TextEditingController _tController;

  @override
  void initState() {
    super.initState();
    _tController = TextEditingController();

  }

  @override
  void dispose() {
    _tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioTranslateController = ref.read(audioTranslateSProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center ,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          ref.watch(audioTranslateController.audioFile) == ""
              ? Icons.music_off_outlined
              : Icons.music_note_outlined,
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
                onPressed: () async {
                  // var file =await ref
                  //     .read(uploadFileProvider)
                  //     .pickFileData(2,3);
                  // ref.read(audioTranslateController.audioFile.notifier).update((state) =>file.path);
                }, child: Text("Start recording")),
            ElevatedButton(
                onPressed: () async {
                  // var file =await ref
                  //     .read(uploadFileProvider)
                  //     .pickFileData(2,3);
                  // ref.read(audioTranslateController.audioFile.notifier).update((state) =>file.path);
                }, child: Text("Stop recording"))
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              var file =await ref
                  .read(uploadFileProvider)
                  .pickFileData(1,3);
              ref.read(audioTranslateController.audioFile.notifier).update((state) =>file.path);
            }, child: Text("Upload a audio from storage"))
      ],
    );
  }
}
