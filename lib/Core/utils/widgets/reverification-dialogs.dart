import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:restaurent_seating_mobile_frontend/Core/app_export.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/email-verification.dart';

reverificationWarningDialogs(BuildContext context, msg, String emailText) {
  Dialogs.materialDialog(
      color: Colors.white,
      msg: msg,
      title: appName,
      context: context,
      barrierDismissible: false,
      lottieBuilder: LottieBuilder.asset(
        "assets/alert.json",
        repeat: true,
        width: 100,
        height: 100,
      ),
      actions: [
        IconsButton(
          onPressed: () {
            if (emailText == 'login') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => const SignInScreen()),
                  (Route<dynamic> route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => ConfirmYourEmailScreen(emailText, '')),
                  (Route<dynamic> route) => false);
            }
          },
          text: "Proceed",
          //iconData: Icons.ok,
          color: ColorConstant.amberA700,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ]);
}
