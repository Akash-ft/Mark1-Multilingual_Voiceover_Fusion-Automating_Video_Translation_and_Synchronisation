import 'base_model.dart';

class UploadFileRequestModel extends BaseModel<UploadFileRequestModel> {
  String? updFilePath;

  @override
  Map<String, dynamic> toJson() => {
        "updFilePath": updFilePath,
      };

  @override
  UploadFileRequestModel fromJson(Map<String, dynamic> json) {
    updFilePath = json["updFilePath"];

    return this;
  }
}
