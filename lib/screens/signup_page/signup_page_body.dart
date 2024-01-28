import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rootasjey/components/buttons/dark_elevated_button.dart';
import 'package:rootasjey/components/fade_in_y.dart';
import 'package:rootasjey/globals/constants.dart';
import 'package:rootasjey/globals/utilities.dart';
import 'package:unicons/unicons.dart';

class SignupPageBody extends StatelessWidget {
  const SignupPageBody({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.emailErrorMessage,
    required this.usernameErrorMessage,
    required this.confirmPasswordController,
    required this.emailController,
    this.onSubmit,
    this.onUsernameChanged,
    this.onPasswordChanged,
    this.onNavigateToForgotPassword,
    this.onNavigateToSignin,
    this.onCancel,
    this.onEmailChanged,
    this.onConfirmPasswordChanged,
    this.confirmPasswordErrorMessage = "",
    this.checkingEmail = false,
    this.checkingUsername = false,
  });

  /// True if checking the server for email availability.
  final bool checkingEmail;

  /// True if checking the server for username availability.
  final bool checkingUsername;

  /// Callback fired to go back or exit this page.
  final void Function()? onCancel;

  /// Callback fired when typed confirm password changed.
  final void Function(
    String password,
    String confirmPassword,
  )? onConfirmPasswordChanged;

  /// Callback fired when typed email changed.
  final void Function(String email)? onEmailChanged;

  /// Callback fired when typed password changed.
  final void Function(String password)? onPasswordChanged;

  /// Callback fired to the forgot password page.
  final void Function()? onNavigateToForgotPassword;

  /// Callback fired to the create account page.
  final void Function()? onNavigateToSignin;

  /// Callback fired when the user validate their information and want to signin.
  final void Function(
    String name,
    String email,
    String password,
    String confirmPassword,
  )? onSubmit;

  /// Callback fired when typed name changed.
  final void Function(String name)? onUsernameChanged;

  /// Error message about the confirm password.
  final String confirmPasswordErrorMessage;

  /// Error message about the email.
  final String emailErrorMessage;

  /// Error message about the username.
  final String usernameErrorMessage;

  /// Input controller for the confirm password.
  final TextEditingController confirmPasswordController;

  /// Input controller for the email.
  final TextEditingController emailController;

  /// Input controller for the password.
  final TextEditingController passwordController;

  /// Input controller for the username.
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 40.0),
          width: 600.0,
          child: Column(children: [
            header(context),
            usernameInput(context),
            emailInput(context),
            passwordInputs(context),
            footerButtons(),
          ]),
        ),
      ),
    );
  }

  Widget confirmPasswordInput(BuildContext context,
      {double inputWidth = 260.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "password_confirm".tr(),
              style: Utilities.fonts.body(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
          child: SizedBox(
            width: inputWidth,
            child: TextField(
              autofocus: false,
              controller: confirmPasswordController,
              obscureText: true,
              textInputAction: TextInputAction.go,
              onSubmitted: (String confirmPassword) {
                onSubmit?.call(
                  usernameController.text,
                  emailController.text,
                  passwordController.text,
                  confirmPassword,
                );
              },
              onChanged: (String confirmPassword) {
                onConfirmPasswordChanged?.call(
                  passwordController.text,
                  confirmPassword,
                );
              },
              decoration: InputDecoration(
                hintText: "•••••••••••",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.colors.palette.elementAt(1),
                    width: 4.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.4) ??
                        Colors.white12,
                    width: 4.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget emailErrorMessageWidget() {
    if (emailErrorMessage.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        emailErrorMessage,
        style: TextStyle(
          color: Colors.red.shade300,
        ),
      ),
    );
  }

  Widget emailCheckProgress() {
    if (checkingEmail) {
      return const LinearProgressIndicator(
        color: Colors.lightBlue,
      );
    }

    return const SizedBox();
  }

  Widget emailInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              top: 16.0,
            ),
            child: Text(
              "email".tr(),
              style: Utilities.fonts.body(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
          child: TextField(
            autofocus: false,
            controller: emailController,
            onChanged: onEmailChanged,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "steven@universe.galaxy",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.colors.palette.first,
                  width: 4.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.4) ??
                      Colors.white12,
                  width: 4.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.colors.palette.first,
                  width: 4.0,
                ),
              ),
            ),
          ),
        ),
        emailCheckProgress(),
        emailErrorMessageWidget(),
      ],
    );
  }

  Widget footerButtons() {
    final Color randomAccentColor = Constants.colors.getRandomFromPalette();

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInY(
            beginY: Utilities.ui.getBeginY(),
            delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
            child: DarkElevatedButton.icon(
              iconData: UniconsLine.times,
              labelValue: "cancel".tr(),
              background: Colors.black,
              onPressed: () => onCancel?.call(),
              minimumSize: const Size(250.0, 60.0),
            ),
          ),
          FadeInY(
            beginY: Utilities.ui.getBeginY(),
            delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
            child: DarkElevatedButton.large(
              onPressed: () {
                onSubmit?.call(
                  usernameController.text,
                  emailController.text,
                  passwordController.text,
                  confirmPasswordController.text,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "signin".tr(),
                      style: Utilities.fonts.body(
                        textStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: randomAccentColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        UniconsLine.arrow_right,
                        color: randomAccentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Column(
      children: [
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(
            milliseconds: Utilities.ui.getNextAnimationDelay(reset: true),
          ),
          child: Icon(
            UniconsLine.trees,
            size: 42.0,
            color: Constants.colors.palette.first,
          ),
        ),
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(
            milliseconds: Utilities.ui.getNextAnimationDelay(),
          ),
          child: Text(
            "signup".tr(),
            style: Utilities.fonts.body(
              textStyle: const TextStyle(
                fontSize: 42.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(
            milliseconds: Utilities.ui.getNextAnimationDelay(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Opacity(
              opacity: 0.4,
              child: Text(
                "account_create_new".tr(),
                textAlign: TextAlign.center,
                style: Utilities.fonts.body2(
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        navigateToCreateAccountButton(),
      ],
    );
  }

  Widget navigateToCreateAccountButton() {
    return FadeInY(
      beginY: Utilities.ui.getBeginY(),
      delay: Duration(
        milliseconds: Utilities.ui.getNextAnimationDelay(),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: TextButton(
            onPressed: onNavigateToSignin,
            style: TextButton.styleFrom(
              backgroundColor: Constants.colors.palette.first.withOpacity(0.3),
              foregroundColor: Colors.white,
            ),
            child: Opacity(
              opacity: 0.8,
              child: Text(
                "account_already_own".tr(),
                style: Utilities.fonts.code(
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget passwordInput(BuildContext context, {double inputWidth = 260.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "password".tr(),
              style: Utilities.fonts.body(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
          child: SizedBox(
            width: inputWidth,
            child: TextField(
              autofocus: false,
              controller: passwordController,
              obscureText: true,
              textInputAction: TextInputAction.next,
              onChanged: onPasswordChanged,
              decoration: InputDecoration(
                hintText: "•••••••••••",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.colors.palette.elementAt(1),
                    width: 4.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.4) ??
                        Colors.white12,
                    width: 4.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordInputs(BuildContext context) {
    const double inputWidth = 260.0;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 600.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                passwordInput(
                  context,
                  inputWidth: inputWidth + 60.0,
                ),
                confirmPasswordInput(
                  context,
                  inputWidth: inputWidth,
                ),
              ],
            ),
          ),
          passwordErrorMessageWidget(),
        ],
      ),
    );
  }

  Widget passwordErrorMessageWidget() {
    if (confirmPasswordErrorMessage.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        confirmPasswordErrorMessage,
        style: TextStyle(
          color: Colors.red.shade300,
        ),
      ),
    );
  }

  Widget usernameCheckProgress() {
    if (checkingUsername) {
      return const LinearProgressIndicator(
        color: Colors.lightBlue,
      );
    }

    return const SizedBox();
  }

  Widget usernameErrorMessageWidget() {
    if (usernameErrorMessage.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        usernameErrorMessage,
        style: TextStyle(
          color: Colors.red.shade300,
        ),
      ),
    );
  }

  Widget usernameInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 54.0,
              bottom: 8.0,
            ),
            child: Text(
              "username".tr(),
              style: Utilities.fonts.body(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        FadeInY(
          beginY: Utilities.ui.getBeginY(),
          delay: Duration(milliseconds: Utilities.ui.getNextAnimationDelay()),
          child: TextField(
            autofocus: true,
            controller: usernameController,
            onChanged: onUsernameChanged,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Melody",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.colors.palette.first,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.4) ??
                      Colors.white12,
                  width: 4.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.colors.palette.first,
                  width: 4.0,
                ),
              ),
            ),
          ),
        ),
        usernameCheckProgress(),
        usernameErrorMessageWidget(),
      ],
    );
  }
}