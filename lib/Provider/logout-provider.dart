import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/app-utils-loader.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-in-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';

class LogoutProvider extends ChangeNotifier {

  /* Logout Dialog */
  logoutDialogs(BuildContext context, msg) {
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
        context: context,
        lottieBuilder: LottieBuilder.asset(
          "assets/logout.json",
          repeat: true,
          width: 100,
          height: 100,
        ),
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
              LogOut(context);
              notifyListeners();
            },
            text: ok,
            color: ColorConstant.amberA700,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: cancel,
            color: ColorConstant.amberA700,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  /* Logout function */
  void LogOut(BuildContext context) async {
    var soc = await SharedPreference().getSignedin();
    var netstatus = await SharedPreference().getinternetstatus();
    if (netstatus.toString() != '') {
      if (soc.toString() != '') {
        AppUtils.showProgressDialog(context, "Please Wait...");
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth = Provider.of<SigninProvider>(context, listen: false);
          auth.cancel();
        });
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth = Provider.of<SigninProvider>(context, listen: false);
          auth.signOut(context);
        });
        notifyListeners();
      }
      final bool result = await SharedPreference().setEmail('');
      final bool resul1t1t = await SharedPreference().setPassword('');
      final bool resul1t1t1 = await SharedPreference().setToken('');
      final bool resultr = await SharedPreference().setSigninStatus('');
      final bool resusocName = await SharedPreference().setSocialLoginName('');
      final bool rescognitoid = await SharedPreference().setCognitoId('');
      final bool resuserId = await SharedPreference().setUserId('');
      if (soc.toString() == '') {
        navigateToSignInScreen(context);
        notifyListeners();
      }
    } else {
      warningDialogs(context, 'You are currently offline');
    }
  }
  
  /* Navigating SignIn Screen function */
  void navigateToSignInScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SignInScreen()),
        (Route<dynamic> route) => false);
  }
}
