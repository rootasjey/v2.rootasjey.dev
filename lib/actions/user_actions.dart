import 'package:cloud_functions/cloud_functions.dart';
import 'package:loggy/loggy.dart';
import 'package:rootasjey/globals/utils.dart';
import 'package:rootasjey/types/cloud_fun_error.dart';
import 'package:rootasjey/types/create_account_response.dart';
import 'package:rootasjey/types/user_action_response.dart';
import 'package:rootasjey/utils/cloud.dart';

/// Network interface for user's actions.
class UserActions {
  /// Check email availability accross the app.
  static Future<bool> checkEmailAvailability(String email) async {
    try {
      final HttpsCallableResult resp =
          await Cloud.fun("users-checkEmailAvailability")
              .call({"email": email});

      final bool? isAvailable = resp.data["isAvailable"];
      return isAvailable ?? false;
    } on FirebaseFunctionsException catch (exception) {
      GlobalLoggy()
          .loggy
          .error("[code: ${exception.code}] - ${exception.message}");
      return false;
    } catch (error) {
      GlobalLoggy().loggy.error(error);
      return false;
    }
  }

  /// Create a new account.
  static Future<CreateAccountResponse> createAccount({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final HttpsCallableResult response =
          await Cloud.fun("users-createAccount").call({
        "username": username,
        "password": password,
        "email": email,
      });

      return CreateAccountResponse.fromMap(response.data);
    } on FirebaseFunctionsException catch (exception) {
      GlobalLoggy()
          .loggy
          .error("[code: ${exception.code}] - ${exception.message}");

      return CreateAccountResponse(
        success: false,
        error: CloudFunError(
          code: exception.code,
          message: exception.message ?? "",
        ),
      );
    } catch (error) {
      return CreateAccountResponse(
        success: false,
        error: CloudFunError(
          code: "",
          message: error.toString(),
        ),
      );
    }
  }

  /// Check email format.
  static bool checkEmailFormat(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}")
        .hasMatch(email);
  }

  /// Check username availability.
  static Future<bool> checkUsernameAvailability(String username) async {
    try {
      final HttpsCallableResult resp =
          await Cloud.fun("users-checkUsernameAvailability")
              .call({"name": username});
      return resp.data["isAvailable"] ?? false;
    } on FirebaseFunctionsException catch (exception) {
      GlobalLoggy()
          .loggy
          .error("[code: ${exception.code}] - ${exception.message}");
      return false;
    } catch (error) {
      GlobalLoggy().loggy.error(error);
      return false;
    }
  }

  /// Check username format.
  /// Must contains 3 or more alpha-numerical characters.
  static bool checkUsernameFormat(String username) {
    final str = RegExp("[a-zA-Z0-9_]{3,}").stringMatch(username);
    return username == str;
  }

  /// Update user's email.
  static Future<UserActionResponse> updateEmail({
    required String email,
    required String idToken,
  }) async {
    try {
      final HttpsCallableResult response =
          await Utils.lambda.fun("users-updateEmail").call({
        "email": email,
        "id_token": idToken,
      });

      return UserActionResponse.fromMap(response.data);
    } catch (error) {
      return UserActionResponse(
        success: false,
      );
    }
  }
}
