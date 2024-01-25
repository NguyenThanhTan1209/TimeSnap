import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'floating_icon_button.dart';

class HeadingAppWidget extends StatelessWidget {
  const HeadingAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FloatingButton(
          icon: Icons.add,
          backgroundColor:
              ColorConstants.ICON_BUTTON_ADD_BACKGROUND_COLOR,
          foregroundColor:
              ColorConstants.ICON_BUTTON_ADD_FOREGROUND_COLOR,
        ),
        FloatingButton(
          icon: Icons.edit_outlined,
          backgroundColor:
              ColorConstants.ICON_BUTTON_EDIT_BACKGROUND_COLOR,
          foregroundColor:
              ColorConstants.ICON_BUTTON_EDIT_FOREGROUND_COLOR,
        ),
      ],
    );
  }
}