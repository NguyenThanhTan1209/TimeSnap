import 'package:flutter/material.dart';
import 'package:show_time/constants/number.dart';

class FloatingButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;

  const FloatingButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: foregroundColor),
      iconSize: NumberConstants.ICON_SIZE_18,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: NumberConstants.ELEVATION_6,
        shadowColor: backgroundColor,
        minimumSize: const Size(NumberConstants.MINIMUM_SIZE_52, NumberConstants.MINIMUM_SIZE_52),
      ),
    );
  }
}