import 'package:network/src/api_helpers/globals.dart';

class UrlUtils {
  /// get Image url based on attachment type
  String getImageURL(String userAttachment, int dataUno) {
    String imageURL;
    var parse = Uri.parse(Globals().url);
    String virtualDirectory = parse.path.split("/")[1];
    imageURL =
    "${parse.scheme}://${parse.authority}/$virtualDirectory/Common/Attachment?";
    return "${imageURL}AttachmentID=$userAttachment&DataUno=$dataUno";
  }

  String getTermsUrl(String customer) {
    String imageURL;
    var parse = Uri.parse(Globals().url);
    String virtualDirectory = parse.path.split("/")[1];
    imageURL =
    "${parse.scheme}://${parse.authority}/$virtualDirectory/Attachments/$customer/Registration/TermsAndConditions.pdf";
    print(imageURL);
    return imageURL;
  }
}
