import 'package:flutter/material.dart';

/// A predefined icon widget style to use in popup menu item.
class PopupMenuIcon extends StatelessWidget {
  const PopupMenuIcon(
    this.iconData, {
    super.key,
    this.color,
  });

  final IconData iconData;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: color,
      size: 20.0,
    );
  }
}
