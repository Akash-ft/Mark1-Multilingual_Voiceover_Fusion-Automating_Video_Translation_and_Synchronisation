import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network/models/upload_file_request.dart';
import 'package:network/models/upload_file_response.dart';
import 'package:network/src/api_helpers/api_helper.dart';
import '../src/repositories_imp/upload_file_rep_imp.dart';

var UploadFileRepositoryProvider =
Provider((ref) => UploadFileRepoImp(ref.read(apiHelperProvider)));

abstract class Repository {
  Future<Either<Exception, UploadFileResponseModel>> uploadFile({
    required UploadFileRequestModel params,
  });

}
