import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final uploadFileProvider = Provider((ref) => UploadFile());

class UploadFile{
  final _picker = ImagePicker();

  Future<dynamic> pickFileData(int targetedSourceUno, int formatUno) async {
    dynamic fileData;
    if (formatUno == 1) {
      if (targetedSourceUno == 1) {
        fileData = await _picker.pickVideo(source: ImageSource.gallery);
      } else if (targetedSourceUno == 2) {
        fileData = await _picker.pickVideo(source: ImageSource.camera);
      }
      return fileData;
    }
    if (formatUno == 2) {
      if (targetedSourceUno == 1) {
        fileData = await _picker.pickImage(source: ImageSource.gallery);
      } else if (targetedSourceUno == 2) {
        fileData = await _picker.pickImage(source: ImageSource.camera);
      }
      return fileData;
    }
    if (formatUno == 3) {
      if (targetedSourceUno == 1) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.audio,
          allowedExtensions: ['mp3', 'wav', 'flac'],
        );
        fileData = result?.files.single.path ?? "";
      } else if (targetedSourceUno == 2) {}
    }
    return fileData;
  }
}
