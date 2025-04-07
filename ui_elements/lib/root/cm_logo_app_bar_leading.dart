import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';

class CMLogoAppBarLeading extends StatelessWidget {
  static const requiredLeadingWidth = horizontalScreenMargin + 65;

  const CMLogoAppBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: horizontalScreenMargin),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/cm_logo.png",
            height: 40,
            width: 65,
            package: "ui_elements",
          ),
        ],
      ),
    );
  }
}
