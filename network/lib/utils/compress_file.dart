import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class CompressFile {
  Future<Uint8List> compressAndGetFile(Uint8List list) async {
    print("Ayush list ${list.lengthInBytes / 1000000}");
    if (list.lengthInBytes <= 1000000) {
      return list;
    }
    var result = await FlutterImageCompress.compressWithList(
      list,
      quality: 80,
    );
    print("Ayush result ${result.lengthInBytes / 1000000}");
    if (result.lengthInBytes <= 1000000) {
      print("Ayush final result ${result.lengthInBytes / 1000000}");
      return result;
    } else {
      return compressAndGetFile(result);
    }
  }
}
