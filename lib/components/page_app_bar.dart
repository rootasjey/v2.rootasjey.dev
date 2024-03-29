import "dart:ui";

import "package:beamer/beamer.dart";
import "package:flutter/material.dart";
import "package:flutter_tabler_icons/flutter_tabler_icons.dart";
import "package:rootasjey/components/buttons/circle_button.dart";
import "package:rootasjey/globals/utils.dart";
import "package:rootasjey/router/locations/home_location.dart";

class PageAppBar extends StatelessWidget {
  const PageAppBar({
    super.key,
    this.axis = Axis.vertical,
    this.isMobileSize = false,
    this.toolbarHeight = 200.0,
    this.children = const [],
  });

  /// Page's axis.
  final Axis axis;

  /// Adapt the user interface to small screens if true.
  final bool isMobileSize;

  /// Page's toolbar height.
  final double toolbarHeight;

  // /// Page's title children.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final String location = Beamer.of(context)
        .beamingHistory
        .last
        .history
        .last
        .routeInformation
        .uri
        .toString();

    final bool hasHistory = location != HomeLocation.route;

    final Color foregroundColor =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8) ??
            Colors.black;

    final List<Widget> childrenLayout = [
      if (hasHistory)
        CircleButton.outlined(
          borderColor: Colors.transparent,
          onTap: () => Utils.passage.back(
            context,
            isMobile: isMobileSize,
          ),
          child: Icon(
            TablerIcons.arrow_left,
            color: foregroundColor,
          ),
        ),
      ...children,
    ];

    final Flex layoutChild = axis == Axis.vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: childrenLayout,
          )
        : Row(children: childrenLayout);

    final Color backgroundColor =
        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6);

    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: false,
      elevation: 6.0,
      toolbarHeight: toolbarHeight,
      centerTitle: false,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Padding(
          padding: isMobileSize
              ? EdgeInsets.zero
              : const EdgeInsets.only(left: 28.0, top: 42.0),
          child: layoutChild,
        ),
      ),
    );
  }
}
