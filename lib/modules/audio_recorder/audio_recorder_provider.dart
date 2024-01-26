
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record/record.dart';

final VoiceRecordProvider = Provider((ref) => VoiceRecorder());

class VoiceRecorder {
  final record = AudioRecorder();

  void startRecording(String filePath) async {
    if (await record.hasPermission()) {
      await record.start(const RecordConfig(encoder: AudioEncoder.wav),
          path: filePath!);
    } else {
      print('Permission denied');
    }
  }

  void stopRecording() async {
    await record.stop();
  }
}
