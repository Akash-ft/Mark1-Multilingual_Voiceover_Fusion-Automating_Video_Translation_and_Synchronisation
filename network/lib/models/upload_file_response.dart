import 'base_model.dart';

class UploadFileResponseModel extends BaseModel<UploadFileResponseModel> {
  String? audioText;
  String? message;
  String? responseTime;

  @override
  Map<String, dynamic> toJson() => {
    "audioText": audioText,
    "message":message,
    "responseTime":responseTime
  };

  @override
  UploadFileResponseModel fromJson(Map<String, dynamic> json) {
    audioText = json["audioText"];
    message = json["message"];
    responseTime = json["responseTime"];
    return this;
  }
}