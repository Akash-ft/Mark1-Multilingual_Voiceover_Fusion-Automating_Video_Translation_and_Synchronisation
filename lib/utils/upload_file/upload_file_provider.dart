import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_settings/app_enum.dart';

final uploadFileProvider = Provider((ref) => UploadFile());

class UploadFile {
  final _picker = ImagePicker();

  Future<dynamic> pickFileData(int targetedSourceUno, int formatUno) async {
    dynamic fileData;
    if (formatUno == mediaFormatValues[MediaFormatType.video]) {
      if (targetedSourceUno == targetedSourceValues[TargetedSourceType.gallery]) {
        fileData = await _picker.pickVideo(source: ImageSource.gallery);
      } else if (targetedSourceUno == targetedSourceValues[TargetedSourceType.camara]) {
        fileData = await _picker.pickVideo(source: ImageSource.camera);
      }
      return fileData;
    }
    if (formatUno ==mediaFormatValues[MediaFormatType.image]) {
      if (targetedSourceUno == targetedSourceValues[TargetedSourceType.gallery]) {
        fileData = await _picker.pickImage(source: ImageSource.gallery);
      } else if (targetedSourceUno == targetedSourceValues[TargetedSourceType.camara]) {
        fileData = await _picker.pickImage(source: ImageSource.camera);
      }
      return fileData;
    }
    if (formatUno == mediaFormatValues[MediaFormatType.audio]) {
      if (targetedSourceUno == targetedSourceValues[TargetedSourceType.gallery]) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.audio
        );

        fileData = result?.files.single;
      } else if (targetedSourceUno == 2) {}
    }
    return fileData;
  }
}
