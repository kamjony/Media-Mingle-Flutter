import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_mingle/view/constants/app_colors.dart';
import 'package:media_mingle/view/constants/strings.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.facebook,
            color: AppColors.googleColor,
          ),
          const SizedBox(width: 10),
          const Text(
            Strings.facebook,
          )
        ],
      ),
    );
  }
}
