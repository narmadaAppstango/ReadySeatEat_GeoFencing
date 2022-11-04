import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/extensions.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/reverification-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/api-service-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/email-verification.dart';
import 'package:restaurent_seating_mobile_frontend/model/common-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/email-verification-data-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/resend-verificationsignup-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/signup-response-model.dart';

class CreateAccountProvider extends ChangeNotifier {
  Status _status = Status.unauthenticated;

  Status get status => _status;

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  bool _isvalidemail = true;

  bool get isPasswordVisible => _isPasswordVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  bool get isvalidEmail => _isvalidemail;

  final TextEditingController _email = TextEditingController();

  TextEditingController get email => _email;

  final TextEditingController _password = TextEditingController();

  TextEditingController get password => _password;

  final TextEditingController _confirmPassword = TextEditingController();

  TextEditingController get confirmPassword => _confirmPassword;

  final TextEditingController _otp = TextEditingController();

  TextEditingController get otp => _otp;
  
  /* Signup Response Model */
  SignupResponseModel? _signupResponseModel;

  SignupResponseModel? get signupResponseModel => _signupResponseModel;
  
  /* Resend Sign up Code Response */
  ResendSignupCodeResponse? _resendSignupCodeResponse;

  ResendSignupCodeResponse? get resenCodeSignupResponse =>
      _resendSignupCodeResponse;
  
  /* Common Response Data Model */
  CommonResponseDataModel? _commonResponseDataModel;

  CommonResponseDataModel? get commonResponseDataModel =>
      _commonResponseDataModel;
  
  /* Email Verification Response Model */
  EmailVerificationResponseModel? _emailVerificationResponseDataModel;

  EmailVerificationResponseModel? get emailVerificationResponseDataModel =>
      _emailVerificationResponseDataModel;
  
  /* Create User function */
  createUser(BuildContext context) {
    if (email.text.trim().isNotEmpty && email.text.trim().isValidEmail()) {
      if (password.text.trim().isNotEmpty) {
        if (password.text.trim().isValidPassword()) {
          if (confirmPassword.text.trim().isNotEmpty) {
            if (confirmPassword.text.trim().isValidPassword()) {
              if (confirmPassword.text.trim() == password.text.trim()) {
                callSignUpAPI(context);
              } else {
                warningDialogs(context, passwordnotMatchText);
              }
            } else {
              warningDialogs(context, passwordWarningText);
            }
          } else {
            warningDialogs(context, confirmpasswarnText);
          }
        } else {
          warningDialogs(context, passwordWarningText);
        }
      } else {
        warningDialogs(context, passWarnText);
      }
    } else {
      warningDialogs(context, emailWarningText);
    }
  }

  clearData() {
    email.clear();
    password.clear();
    confirmPassword.clear();
  }
 
  /* Call SIgn Up API function */
  Future<SignupResponseModel?> callSignUpAPI(BuildContext context) async {
    _status = Status.authenticating;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _signupResponseModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .userCreateApi(email.text.trim(), password.text.trim());
      _status = Status.authenticated;
      notifyListeners();
      if (_signupResponseModel!.status != null) {
        if (_signupResponseModel?.status == true) {
          password.clear();
          _confirmPassword.clear();
          otp.clear();
          String emailText = email.text;
          email.clear();
          navigateToVerificationScreen(context, emailText);
        } else {
          if (_signupResponseModel!.message!.contains(
              "Your account has not been verified, please resend verification email")) {
            password.clear();
            confirmPassword.clear();
            String resEmailText = email.text.trim().toString();
            email.clear();
            resendVerificationCode(context, resEmailText);
          } else {
            email.clear();
            password.clear();
            confirmPassword.clear();
            warningDialogs(context, _signupResponseModel?.message);
          }
        }
      } else {
        warningDialogs(context, 'Internal server error, Please try again');
      }
    } else {
      _status = Status.unauthenticated;
      email.clear();
      password.clear();
      confirmPassword.clear();
      warningDialogs(context, _signupResponseModel?.message);
    }
  }

  navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  navigateToVerificationScreen(BuildContext context, String emailText) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) =>
              ConfirmYourEmailScreen(emailText, 'VerifyEmail')),
    );
  }

  togglePassword(isPasswordVisible) {
    _isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  toggleConfirmPasswordVisible(isConfirmPasswordVisible) {
    _isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }
  
  /* Call Resend Code API function */
  Future<ResendSignupCodeResponse?> resendVerificationCode(
      BuildContext context, String emailT) async {
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _resendSignupCodeResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .resendCodeApi(emailT);
      if (_resendSignupCodeResponse!.message != null) {
        if (_resendSignupCodeResponse?.status == true) {
          reverificationWarningDialogs(
              context, _signupResponseModel!.message, emailT);
        } else {
          warningDialogs(context, _resendSignupCodeResponse?.message);
        }
      } else {
        warningDialogs(context, 'Internal server error, Please try again');
      }
    } else {
      warningDialogs(context, 'You are currently offline');
    }
  }
}
