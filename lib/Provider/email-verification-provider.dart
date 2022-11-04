import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/reverification-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/api-service-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/email-confirmed-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/email-verification.dart';
import 'package:restaurent_seating_mobile_frontend/model/email-verification-data-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/resend-verificationsignup-model.dart';

class EmailVerificationProvider extends ChangeNotifier {
  Status _status = Status.unauthenticated;

  Status get status => _status;

  final TextEditingController _email = TextEditingController();

  TextEditingController get email => _email;

  TextEditingController _otp = TextEditingController();

  TextEditingController get otp => _otp;
  
  /* Email Verification response */
  EmailVerificationResponseModel? _emailVerificationResponseModel;
  EmailVerificationResponseModel? get emailVerificationResponseModel =>
      _emailVerificationResponseModel;
  
  /* Resend sign up response */
  ResendSignupCodeResponse? _resendSignupCodeResponse;
  ResendSignupCodeResponse? get resendSignupCodeResponse =>
      _resendSignupCodeResponse;
  
  /* Verify Email Validation Function */
  verifyEmail(BuildContext context, String emailText) {
    if (otp.text.trim().length == 6) {
      callEmailVerificationAPI(context, emailText);
    } else {
      warningDialogs(context, otpWarningTest);
    }
  }

  /* Resend Email validation function */
  resendEmail(BuildContext context, String emailText) {
    if (emailText.isNotEmpty) {
      callresendCodeApi(context, emailText);
    } else {
      warningDialogs(context, otpWarningTest);
    }
  }
  
  /* Call resend Code API */
  Future<ResendSignupCodeResponse?> callresendCodeApi(
      BuildContext context, String emailText) async {
    _status = Status.authenticating;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _resendSignupCodeResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .resendCodeApi(emailText);
      _status = Status.authenticated;
      notifyListeners();
      if (_resendSignupCodeResponse?.status == true) {
        otp.clear();
        // navigateToEmailVerificationScreen(context, emailText);
      } else {
        otp.clear();
        warningDialogs(context, _resendSignupCodeResponse!.message);
      }
    } else {
      otp.clear();
      warningDialogs(context, 'You are currently offline');
    }
  }
  
  /* Call Email Verification API */
  Future<EmailVerificationResponseModel?> callEmailVerificationAPI(
      BuildContext context, String emailText) async {
    _status = Status.authenticating;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _emailVerificationResponseModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .emailVerificationApi(otp.text, emailText);
      _status = Status.authenticated;
      notifyListeners();
      if (emailVerificationResponseModel?.status == true) {
        otp.clear();
        sucessDialogs(context, emailVerificationResponseModel!.message,
            'Email Verification');
        //navigateToConfirmScreen(context);
      } else {
        otp.clear();
        if (emailVerificationResponseModel!.message ==
            'User already confirmed') {
          reverificationWarningDialogs(context,
              'User already confirmed so please proceed to login', 'login');
        } else {
          otp.clear();
          warningDialogs(context, emailVerificationResponseModel!.message);
        }
      }
    } else {
      otp.clear();
      warningDialogs(context, 'You are currently offline');
    }
  }
  
  /* Email Verification Screen */
  navigateToEmailVerificationScreen(BuildContext context, String emailTexts) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              ConfirmYourEmailScreen(emailTexts, 'Email Verifcation')),
    );
  }
  
  /* Account Confirm Screen */
  navigateToConfirmScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AccountConfirmedScreen()));
  }
}
