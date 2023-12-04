
import 'package:b_native/utils/upload_file/upload_file_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'controller.dart';

class ImageTranslateWidget extends ConsumerStatefulWidget {
  const ImageTranslateWidget({super.key});

  @override
  ConsumerState<ImageTranslateWidget> createState() =>
      _ImageTranslateWidgetState();
}

class _ImageTranslateWidgetState extends ConsumerState<ImageTranslateWidget> {
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
    final imageTranslateController = ref.read(imageTranslateSProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center ,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          ref.watch(imageTranslateController.imageFile) == ""
              ? Icons.image_not_supported
              : Icons.image,
          size: 30,
        ),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              var file =
              await ref
                  .read(uploadFileProvider)
                  .pickFileData(1,2);
              ref.read(imageTranslateController.imageFile.notifier).update((state) =>file.path);
            },
            child: Text("Upload from  Storage")),
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
            onPressed: () async {
              var file =await ref
                  .read(uploadFileProvider)
                  .pickFileData(2,2);
              ref.read(imageTranslateController.imageFile.notifier).update((state) =>file.path);
            }, child: Text("click from Camera")),
      ],
    );
  }
}
