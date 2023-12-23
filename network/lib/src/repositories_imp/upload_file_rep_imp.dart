import 'package:dartz/dartz.dart';
import 'package:network/models/upload_file_request.dart';
import 'package:network/models/upload_file_response.dart';
import 'package:network/src/api_helpers/api_helper.dart';

import '../../repositories/upload_file_repository.dart';

class UploadFileRepoImp extends Repository {
  final ApiHelper apiHelper;

  UploadFileRepoImp(this.apiHelper);

  @override
  Future<Either<Exception, UploadFileResponseModel>> uploadFile(
      {required UploadFileRequestModel params}) {
    return apiHelper.postRequest(
      path: "/audio",
      body: params.toJson(),
      create: () => UploadFileResponseModel(),
    );
  }
}
