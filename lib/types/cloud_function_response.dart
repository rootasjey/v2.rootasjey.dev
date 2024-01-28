import 'package:rootasjey/types/cloud_func_error.dart';
import 'package:rootasjey/types/partial_user.dart';

class CloudFunctionsResponse {
  bool success;
  final CloudFuncError? error;
  final PartialUser? user;

  CloudFunctionsResponse({
    this.success = true,
    this.error,
    this.user,
  });

  factory CloudFunctionsResponse.fromJSON(Map<dynamic, dynamic> data) {
    return CloudFunctionsResponse(
      success: data["success"] ?? true,
      user: PartialUser.fromJSON(data["user"]),
      error: CloudFuncError.fromJSON(data["error"]),
    );
  }
}
