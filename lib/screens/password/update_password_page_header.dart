import "package:beamer/beamer.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_tabler_icons/flutter_tabler_icons.dart";
import "package:rootasjey/globals/constants.dart";
import "package:rootasjey/globals/utils.dart";
import "package:rootasjey/types/password_checks.dart";

class UpdatePasswordPageHeader extends StatelessWidget {
  const UpdatePasswordPageHeader({
    super.key,
    required this.passwordChecks,
    this.isMobileSize = false,
    this.accentColor,
    this.margin = EdgeInsets.zero,
    this.onTapLeftPartHeader,
  });

  /// Adapt the user interface to narrow screen's size if true.
  final bool isMobileSize;

  /// Accent color.
  final Color? accentColor;

  /// Space around this widget.
  final EdgeInsets margin;

  /// Callback fired when left part header is tapped.
  final void Function()? onTapLeftPartHeader;

  /// Indicates if all requirements for the new password are met.
  final PasswordChecks passwordChecks;

  @override
  Widget build(BuildContext context) {
    const FontWeight fontWeight = FontWeight.w500;
    final Color? foregroundColor =
        Theme.of(context).textTheme.bodyMedium?.color;

    return SliverToBoxAdapter(
      child: Padding(
        padding: isMobileSize
            ? const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0)
            : const EdgeInsets.only(top: 72.0),
        child: Column(
          crossAxisAlignment: isMobileSize
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            ActionChip(
              onPressed: context.beamBack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(TablerIcons.arrow_left),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("back".tr()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onTapLeftPartHeader,
                  child: Text(
                    "settings.name".tr(),
                    textAlign: isMobileSize ? TextAlign.left : TextAlign.center,
                    style: Utils.calligraphy.body(
                      textStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: fontWeight,
                        height: 1.0,
                        color: foregroundColor?.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "password.name".tr(),
              textAlign: isMobileSize ? TextAlign.left : TextAlign.center,
              style: Utils.calligraphy.body(
                textStyle: TextStyle(
                  color: accentColor,
                  fontWeight: fontWeight,
                  fontSize: 54.0,
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: isMobileSize ? 0.9 : 0.4,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "password.update.tips.minimum_length".tr(args: ["6"]),
                      style: TextStyle(
                        color: passwordChecks.hasMinimumLength
                            ? Constants.colors.palette.first
                            : null,
                        fontWeight: passwordChecks.hasMinimumLength
                            ? FontWeight.w800
                            : null,
                      ),
                    ),
                    const TextSpan(text: ", "),
                    TextSpan(
                      text: "password.update.tips.lower_case".tr(),
                      children: const [TextSpan(text: ", ")],
                      style: TextStyle(
                        color: passwordChecks.hasLowercase
                            ? Constants.colors.palette.elementAt(1)
                            : null,
                        fontWeight: passwordChecks.hasLowercase
                            ? FontWeight.w800
                            : null,
                      ),
                    ),
                    TextSpan(
                      text: "password.update.tips.upper_case".tr(),
                      children: const [TextSpan(text: ", ")],
                      style: TextStyle(
                        color: passwordChecks.hasUppercase
                            ? Constants.colors.palette.elementAt(2)
                            : null,
                        fontWeight: passwordChecks.hasUppercase
                            ? FontWeight.w800
                            : null,
                      ),
                    ),
                    TextSpan(
                      text: "password.update.tips.and".tr(),
                      children: const [TextSpan(text: " ")],
                    ),
                    TextSpan(
                      text: "password.update.tips.number".tr(),
                      children: const [TextSpan(text: ".")],
                      style: TextStyle(
                        color: passwordChecks.hasDigit
                            ? Constants.colors.palette.elementAt(3)
                            : null,
                        fontWeight:
                            passwordChecks.hasDigit ? FontWeight.w600 : null,
                      ),
                    ),
                  ],
                ),
                style: Utils.calligraphy.body(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    color: foregroundColor?.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ]
              .animate(interval: 50.ms)
              .fadeIn(duration: 200.ms, curve: Curves.decelerate)
              .slideY(begin: 0.4, end: 0.0),
        ),
      ),
    );
  }
}
