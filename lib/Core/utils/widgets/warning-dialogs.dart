import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/edit-profile-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/email-confirmed-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/email-verification.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';

warningDialogs(BuildContext context, msg) {
  Dialogs.materialDialog(
      color: Colors.white,
      msg: msg,
      title: appName,
      barrierDismissible: false,
      msgStyle: TextStyle(
          color: ColorConstant.black900,
          wordSpacing: 1.3,
          fontSize: 14,
          letterSpacing: 0.3,
          fontWeight: FontWeight.w500,
          fontFamily: 'OpenSansSemiBold'),
      //animation: 'assets/coming-soon.json',
      context: context,
      lottieBuilder: LottieBuilder.asset(
        "assets/alert.json",
        repeat: true,
        width: 100,
        height: 100,
      ),
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.pop(context);
            //SystemNavigator.pop();
          },
          text: ok,
          //iconData: Icons.ok,
          color: ColorConstant.amberA700,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ]);
}

sucessDialogs(BuildContext context, msg, String mode) {
  Dialogs.materialDialog(
      color: Colors.white,
      msg: msg,
      title: appName,
      barrierDismissible: false,
      msgStyle: TextStyle(
          color: ColorConstant.black900,
          wordSpacing: 1.3,
          fontSize: 14,
          letterSpacing: 0.3,
          fontWeight: FontWeight.w500,
          fontFamily: 'OpenSansSemiBold'),
      //animation: 'assets/coming-soon.json',
      context: context,
      lottieBuilder: LottieBuilder.asset(
        "assets/sucess.json",
        repeat: true,
        width: 100,
        height: 100,
      ),
      actions: [
        IconsButton(
          onPressed: () {
            if (mode == 'Edit Profile') {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                        title: 'Edit Profile', titlechange: true)),
              );
            } else if (mode == 'Email Verification') {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountConfirmedScreen()));
            } else if (mode == 'Verify') {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PresentReservationScreen()));
            } else {
              Navigator.pop(context);
            }
          },
          text: ok,
          //iconData: Icons.ok,
          color: ColorConstant.amberA700,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ]);
}
