import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rootasjey/components/inputs/outlined_text_field.dart';
import 'package:rootasjey/globals/utils.dart';
import 'package:rootasjey/types/enums/enum_page_state.dart';

class UpdateUsernamePageBody extends StatelessWidget {
  const UpdateUsernamePageBody({
    super.key,
    required this.usernameController,
    required this.passwordFocusNode,
    this.isMobileSize = false,
    this.pageState = EnumPageState.idle,
    this.errorMessage = "",
    this.onUsernameChanged,
    this.onTapUpdateButton,
  });

  /// True if the screen's size is narrow.
  final bool isMobileSize;

  /// Username text controller.
  final TextEditingController usernameController;

  /// Password focus node.
  final FocusNode passwordFocusNode;

  /// Page's state (e.g. loading, idle, ...).
  final EnumPageState pageState;

  /// On username input changed.
  final void Function(String value)? onUsernameChanged;

  /// On username input changed.
  final void Function()? onTapUpdateButton;

  /// Error message.
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final Color secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;

    return SliverToBoxAdapter(
      child: Container(
        width: isMobileSize ? null : 360.0,
        padding: isMobileSize
            ? const EdgeInsets.all(24.0)
            : const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Container(
              width: isMobileSize ? null : 352.0,
              margin: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                children: <Widget>[
                  OutlinedTextField(
                    autofocus: true,
                    controller: usernameController,
                    label: "username.new".tr(),
                    keyboardType: TextInputType.text,
                    onChanged: onUsernameChanged,
                    textInputAction: TextInputAction.go,
                  ),
                  Opacity(
                    opacity:
                        pageState == EnumPageState.checkingUsername ? 1.0 : 0.0,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: LinearProgressIndicator(),
                    ),
                  ),
                  Opacity(
                    opacity: errorMessage.isEmpty ? 0.0 : 1.0,
                    child: Text(
                      errorMessage,
                      style: Utils.calligraphy.body(
                        textStyle: TextStyle(
                          color: secondaryHeaderColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onTapUpdateButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
              ),
              child: Container(
                padding: const EdgeInsets.all(14.0),
                width: 320.0,
                child: Text(
                  "update.name".tr().toUpperCase(),
                  softWrap: true,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Utils.calligraphy.body(
                    textStyle: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]
              .animate(delay: 250.ms, interval: 50.ms)
              .fadeIn(duration: 200.ms, curve: Curves.decelerate)
              .slideY(begin: 0.6, end: 0.0),
        ),
      ),
    );
  }
}
