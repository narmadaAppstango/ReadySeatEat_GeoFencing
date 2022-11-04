import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/extensions.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/api-service-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/logout-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/forget-password-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/forgot-password-confirmscreen.dart';
import 'package:restaurent_seating_mobile_frontend/model/common-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/forget-password-responsemodel.dart';
import 'package:restaurent_seating_mobile_frontend/model/reset-password-model.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  final TextEditingController _email = TextEditingController();
  Status _status = Status.unauthenticated;

  Status get status => _status;

  TextEditingController get email => _email;

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  bool _isoldPasswordVisible = true;

  bool get isPasswordVisible => _isPasswordVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  bool get isoldPasswordVisible => _isoldPasswordVisible;

  TextEditingController _otp = TextEditingController();

  TextEditingController get otp => _otp;

  TextEditingController _password = TextEditingController();

  TextEditingController get password => _password;

  TextEditingController _confirmpassword = TextEditingController();

  TextEditingController get confirmPassword => _confirmpassword;

  TextEditingController _oldpassword = TextEditingController();

  TextEditingController get oldpassword => _oldpassword;
  
  /* Forgot password Response */
  ForgetPasswordResponseModel? _forgetPasswordResponseDataModel;

  ForgetPasswordResponseModel? get forgetPasswordResponseDataModel =>
      _forgetPasswordResponseDataModel;
 
  /* Reset Password Response */
  ResetPasswordResponseDataModel? _resetPasswordResponseDataModel;

  ResetPasswordResponseDataModel? get resetPasswordResponseDataModel =>
      _resetPasswordResponseDataModel;
  
  /* Clear Data */
  clearData() {
    email.clear();
    oldpassword.clear();
    password.clear();
    confirmPassword.clear();
    _status = Status.unauthenticated;
    notifyListeners();
  }
  
  /* Forgot password validating function */
  forgetPassword(BuildContext context) {
    if (email.text.trim().isNotEmpty && email.text.trim().isValidEmail()) {
      String emailText = email.text.trim();
      email.clear();
      callForgetPasswordApi(context, emailText);
    } else {
      warningDialogs(context, emailWarningText);
    }
  }

  /* Resend Code function */
  resendCode(BuildContext context, String resendemail) {
    if (resendemail.trim().isNotEmpty && resendemail.trim().isValidEmail()) {
      resendCodeApi(context, resendemail);
    } else {
      warningDialogs(context, emailWarningText);
    }
  }
  
  /* Resend Code API function */
  Future<ForgetPasswordResponseModel?> resendCodeApi(
      BuildContext context, String resendemail) async {
    _status = Status.authenticating;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _forgetPasswordResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .forgetPasswordApi(resendemail);
      _status = Status.authenticated;
      notifyListeners();
      if (forgetPasswordResponseDataModel!.status == true) {
        String emailText = resendemail.toString();
        email.clear();
        // navigateToResetPasswordScreen(context, emailText);
      } else {
        _status = Status.unauthenticated;
        email.clear();
        warningDialogs(context, forgetPasswordResponseDataModel!.message);
      }
    } else {
      _status = Status.unauthenticated;
      email.clear();
      warningDialogs(context, 'You are currently offline');
    }
  }
  
  /* Call Forgot password API function */
  Future<ForgetPasswordResponseModel?> callForgetPasswordApi(
      BuildContext context, String mailText) async {
    _status = Status.authenticating;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _forgetPasswordResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .forgetPasswordApi(mailText);
      _status = Status.authenticated;
      notifyListeners();
      if (forgetPasswordResponseDataModel!.status == true) {
        String emailText = mailText;
        email.clear();
        navigateToResetPasswordScreen(context, emailText);
      } else {
        _status = Status.unauthenticated;
        email.clear();
        warningDialogs(context, forgetPasswordResponseDataModel!.message);
      }
    } else {
      _status = Status.unauthenticated;
      email.clear();
      warningDialogs(context, 'You are currently offline');
    }
  }
  
  /* Reset Password validating function */
  resetPassword(BuildContext context, emailText) {
    if (otp.text.trim().length == 6) {
      if (password.text.trim().isNotEmpty) {
        if (password.text.trim().isValidPassword()) {
          if (confirmPassword.text.trim().isNotEmpty) {
            if (confirmPassword.text.trim().isValidPassword()) {
              if (confirmPassword.text.trim() == password.text.trim()) {
                callResetPasswordApi(context, emailText);
              } else {
                warningDialogs(context, passwordnotMatchText);
              }
            } else {
              warningDialogs(context, passwordWarningText);
            }
          } else {
            warningDialogs(context, confirmpassnewwarnText);
          }
        } else {
          warningDialogs(context, passwordWarningText);
        }
      } else {
        warningDialogs(context, newpassWarnText);
      }
    } else {
      warningDialogs(context, otpWarningTest);
    }
  }
  
  /* Toggle current Password function */
  togglePassword(isPasswordVisible) {
    _isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  /* Toggle Confirm Password function */
  toggleConfirmPasswordVisible(isConfirmPasswordVisible) {
    _isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }
  
  /* Toggle Old Password */
  toggleOldPasswordVisible(isOldPasswordVisible) {
    _isoldPasswordVisible = !isOldPasswordVisible;
    notifyListeners();
  }

  /* Call Reset Password API function */
  Future<ForgetPasswordResponseModel?> callResetPasswordApi(
      BuildContext context, String emailText) async {
    _status = Status.authenticating;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _resetPasswordResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .confirmForgetPasswordApi(
                  otp.text, password.text.trim(), emailText.trim());
      _status = Status.authenticated;
      notifyListeners();
      if (_resetPasswordResponseDataModel?.status == true) {
        email.clear();
        password.clear();
        otp.clear();
        confirmPassword.clear();
        sucessDialogs(context, _resetPasswordResponseDataModel!.message);
        //navigateToLoginScreen(context);
      } else {
        _status = Status.unauthenticated;
        email.clear();
        password.clear();
        otp.clear();
        confirmPassword.clear();
        warningDialogs(context, _resetPasswordResponseDataModel!.message);
      }
    } else {
      _status = Status.unauthenticated;
      email.clear();
      password.clear();
      otp.clear();
      confirmPassword.clear();
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Change Password validating function */
  changePassword(BuildContext context) async {
    var pass = await SharedPreference().getPassword();
    if (oldpassword.text.trim().isNotEmpty) {
      if (oldpassword.text.trim().isValidPassword()) {
        if (oldpassword.text.trim() == pass.toString().trim()) {
          if (password.text.trim().isNotEmpty) {
            if (password.text.trim().isValidPassword()) {
              if (oldpassword.text.trim() != password.text.trim()) {
                if (confirmPassword.text.trim().isNotEmpty) {
                  if (confirmPassword.text.trim().isValidPassword()) {
                    if (password.text.trim() == confirmPassword.text.trim()) {
                      callChangePasswordAPI(
                          context, oldpassword.text, password.text);
                    } else {
                      warningDialogs(context, passwordnotMatchText);
                    }
                  } else {
                    warningDialogs(context, passwordWarningText);
                  }
                } else {
                  warningDialogs(context, confirmpassnewwarnText);
                }
              } else {
                warningDialogs(context, passDiffText);
              }
            } else {
              warningDialogs(context, passwordWarningText);
            }
          } else {
            warningDialogs(context, newpassWarnText);
          }
        } else {
          warningDialogs(context, wrongcurrentpassword);
        }
      } else {
        warningDialogs(context, passwordWarningText);
      }
    } else {
      warningDialogs(context, oldpassWarnText);
    }
  }

  /* Call Change Password API */
  Future<ResetPasswordResponseDataModel?> callChangePasswordAPI(
      BuildContext context, oldPassword, newPassword) async {
    _status = Status.authenticating;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _resetPasswordResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .changePasswordApi(oldPassword, newPassword);
      _status = Status.authenticated;
      notifyListeners();
      if (_resetPasswordResponseDataModel?.status == true) {
        oldpassword.clear();
        password.clear();
        confirmPassword.clear();
        sucessDialogs(
            context, _resetPasswordResponseDataModel!.response!.message);
      } else {
        _status = Status.unauthenticated;
        oldpassword.clear();
        password.clear();
        confirmPassword.clear();
        warningDialogs(context, _resetPasswordResponseDataModel!.message);
      }
    } else {
      _status = Status.unauthenticated;
      oldpassword.clear();
      password.clear();
      confirmPassword.clear();
      warningDialogs(context, 'You are currently offline');
    }
  }
  
  /* Reset Password Screen navigating function */
  navigateToResetPasswordScreen(BuildContext context, String emailText) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ForgotPasswordChangeScreen(emailText)),
    );
  }

  /* Clear Data function */
  cleardata() {
    otp.clear();
    password.clear();
    confirmPassword.clear();
    _status = Status.unauthenticated;
    notifyListeners();
  }

  /* Navigating Login Screen */
  navigateToLoginScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  /* Sucess Dialogs */
  sucessDialogs(BuildContext context, msg) {
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
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                final auth =
                    Provider.of<LogoutProvider>(context, listen: false);
                auth.LogOut(context);
              });
              notifyListeners();
              navigateToLoginScreen(context);
            },
            text: ok,
            //iconData: Icons.ok,
            color: ColorConstant.amberA700,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}
