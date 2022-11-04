import 'dart:async';
import 'dart:convert';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/api-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/extensions.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/reverification-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/api-service-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/logout-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/create-profile-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/edit-profile-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/home-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import 'package:restaurent_seating_mobile_frontend/model/SocialLoginResponseModel.dart';
import 'package:restaurent_seating_mobile_frontend/model/common-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/login-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/resend-verificationsignup-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SigninProvider extends ChangeNotifier {
  Status _status = Status.unauthenticated;
  String emailString = '';
  String passwordString = '';
  String tokenString = '';
  String userId = '';
  CognitoAuthSession? sess;
  AuthSession? resp;
  String? _email1;
  String? get email1 => _email1;
  String? _imageUrl;
  String? get imageurl => _imageUrl;
  Status get status => _status;

  bool _isPasswordVisible = true;

  bool get isPasswordVisible => _isPasswordVisible;

  TextEditingController _email = TextEditingController();

  TextEditingController get email => _email;

  TextEditingController _password = TextEditingController();

  TextEditingController get password => _password;

  LoginResponseModel? _loginResponseDataModel;

  LoginResponseModel? get loginResponseDataModel => _loginResponseDataModel;

  CommonResponseDataModel? _commonResponseDataModel;

  CommonResponseDataModel? get commonResponseDataModel =>
      _commonResponseDataModel;

  SocialLoginResponse? _socialResponseDataModel;
  SocialLoginResponse? get socialResponseDataModel => _socialResponseDataModel;

  SignInResult? signInResult;

  SignInResult? get _signInresult => signInResult;
  String socialLoginEmail = '';

  bool isLoading = false;

  bool isclicked = true;

  /* Login validating function */
  doLogin(BuildContext context) {
    if (email.text.trim().isNotEmpty && email.text.trim().isValidEmail()) {
      if (password.text.trim().isNotEmpty) {
        callLoginAPI(context, email.text.trim(), password.text.trim());
      } else {
        warningDialogs(context, passWarnText);
      }
    } else {
      warningDialogs(context, emailWarningText);
    }
  }

  /* Splash login validating function */
  doSplashLogin(BuildContext context, String emailT, String passwordT) {
    if (emailT.trim().isNotEmpty && passwordT.trim().isNotEmpty) {
      if (passwordT.trim().isNotEmpty) {
        callLoginAPI(context, emailT, passwordT);
      } else {
        warningDialogs(context, passWarnText);
      }
    } else {
      warningDialogs(context, emailWarningText);
    }
  }

  /* call Login API function */
  Future<LoginResponseModel?> callLoginAPI(
      BuildContext context, String emailT, String passwordT) async {
    _status = Status.authenticating;
    var netStatus = await SharedPreference().getinternetstatus();
    notifyListeners();
    if (netStatus.toString() != '') {
      _loginResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .userLoginApi(emailT.trim(), passwordT.trim());
      notifyListeners();
      if (_loginResponseDataModel!.message != null) {
        _status = Status.authenticated;
        if (_loginResponseDataModel?.status == true) {
          emailString = email.text.toString().trim();
          passwordString = password.text.toString().trim();
          tokenString = _loginResponseDataModel!.token.toString().trim();
          userId = _loginResponseDataModel!.value!.id.toString().trim();
          email.clear();
          password.clear();
          notifyListeners();
          loginStatus(
              context, emailString, passwordString, tokenString, userId);
        } else {
          if (_loginResponseDataModel!.message!.contains(
              "Your account has not been verified, please resend verification email")) {
            String emailText = email.text.trim();
            email.clear();
            password.clear();
            notifyListeners();
            resendVerificationCode(context, emailText);
          } else {
            email.clear();
            password.clear();
            warningDialogs(context, _loginResponseDataModel!.message);
          }
        }
      } else {
        email.clear();
        password.clear();
        _status = Status.authenticated;
        warningDialogs(context, 'Internal server error,Please Try again');
      }
    } else {
      email.clear();
      password.clear();
      _status = Status.unauthenticated;
      warningDialogs(context, 'You are currently offline');
      notifyListeners();
    }
  }

  /* Resend Signup Code Response */
  ResendSignupCodeResponse? _resendSignupCodeResponse;

  ResendSignupCodeResponse? get resenCodeSignupResponse =>
      _resendSignupCodeResponse;

  /*   Social Login    */
  Future<void> socialSignIn(BuildContext context, String socialLogin) async {
    _status = Status.authenticating;
    isLoading = true;
    isclicked = true;
    notifyListeners();
    try {
      await Amplify.Auth.signOut();
      notifyListeners();
    } on AmplifyException catch (e) {
      _status = Status.unauthenticated;
      print('error' + e.message);
      isLoading = false;
      isclicked = true;
      warningDialogs(context, e.message);
      notifyListeners();
    }
    try {
      // var sign = await Amplify.Auth.signOut(options: SignOutOptions());
      // print('social' + sign.toString());
      signInResult = await Amplify.Auth.signInWithWebUI(
          provider: socialLogin == 'facebook'
              ? AuthProvider.facebook
              : AuthProvider.apple);
      notifyListeners();
      if (signInResult!.isSignedIn) {
        getsocialSignIn(context, socialLogin);
        notifyListeners();
      }
    } on AmplifyException catch (e) {
      _status = Status.unauthenticated;
      isLoading = false;
      isclicked = true;
      warningDialogs(context, e.message);
      notifyListeners();
    }
  }

  /* Get social signin calling function */
  void getsocialSignIn(BuildContext context, String socialLogin) async {
    resp = await Amplify.Auth.fetchAuthSession(
      options: CognitoSessionOptions(getAWSCredentials: true),
    );
    if (resp!.isSignedIn) {
      sess = resp as CognitoAuthSession;
      fetchAuthSession.call(context);
      _sub!.resume();
      parseJwt(context, sess!.userPoolTokens!.idToken.toString(), socialLogin,
          sess!);
    }
  }

  /* Call Stream function */
  final Stream _myStream =
      Stream.periodic(const Duration(seconds: 5), (int count) {
    return count;
  });
  StreamSubscription? _sub;

  /* cancel subscription */
  void cancel() {
    _sub!.pause();
  }

  /* Fetch Auth Session of Social login users Stream calling */
  void fetchAuthSession(BuildContext context) async {
    _sub = _myStream.listen((event) async {
      final result = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      var sociallogin = (result as CognitoAuthSession).isSignedIn.toString();
      print(sociallogin);
      loginsStatus(context, result.userPoolTokens!.accessToken.toString());
    });
  }

  /* Set Login Acess token to shared preference */
  loginsStatus(BuildContext context, String token) async {
    final bool resultoken = await SharedPreference().setToken(token);
  }

  /* Set social login user details on shared preference */
  socialloginStatus(BuildContext context, String email, String token,
      String signinStatus, String socName, String userId) async {
    final bool result = await SharedPreference().setEmail(email);
    final bool resultoken = await SharedPreference().setToken(token);
    final bool resultuserId =
        await SharedPreference().setSigninStatus(signinStatus);
    final bool resulsocName =
        await SharedPreference().setSocialLoginName(socName);
    final bool resultcogId = await SharedPreference().setCognitoId(userId);
    _socialResponseDataModel =
        await Provider.of<APIServiceProvider>(context, listen: false)
            .socialLoginapi(email, socName, userId);
    final bool resultId = await SharedPreference().setUserId(
        _socialResponseDataModel!.user!.userDbDetails!.id.toString());
    _status = Status.authenticated;
    isLoading = false;
    if (_socialResponseDataModel!.user!.userDbDetails!.profileCreated ==
        false) {
      _status = Status.authenticated;
      notifyListeners();
      navigateToCreateProfileScreen(context);
    } else {
      _status = Status.authenticated;
      isLoading = false;
      notifyListeners();
      // navigateToHomeScreen(context);
      navigateToPresentReserveScreen(context);
    }
    notifyListeners();
  }

  /* Decode the Token and get details */
  Map<String, dynamic> parseJwt(BuildContext context, String token,
      String socName, CognitoAuthSession sess) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    socialloginStatus(
        context,
        payloadMap['email'],
        sess.userPoolTokens!.accessToken.toString(),
        sess.isSignedIn.toString(),
        socName,
        payloadMap['cognito:username']);
    return payloadMap;
  }

  /* Decode Base 64 String from token */
  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }
    return utf8.decode(base64Url.decode(output));
  }

  /* Sign Out Function */
  Future<void> signOut(BuildContext context) async {
    try {
      await Amplify.Auth.signOut(options: SignOutOptions(globalSignOut: true));
      notifyListeners();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  /* Resend Sign up Code API Calling function */
  Future<ResendSignupCodeResponse?> resendVerificationCode(
      BuildContext context, String emailText) async {
    notifyListeners();
    var netstatus = await SharedPreference().getinternetstatus();
    if (netstatus.toString() != '') {
      _resendSignupCodeResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .resendCodeApi(emailText);
      if (_resendSignupCodeResponse != null) {
        if (_resendSignupCodeResponse?.status == true) {
          reverificationWarningDialogs(
              context, _loginResponseDataModel!.message, emailText);
        } else {
          warningDialogs(context, _resendSignupCodeResponse?.message);
        }
      } else {
        warningDialogs(context, 'Internal server error,Please Try again');
      }
    } else {
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Set User details from the response to shared preference */
  loginStatus(BuildContext context, String email, String password, String token,
      String userId) async {
    final bool result = await SharedPreference().setEmail(email);
    final bool resul1t1t = await SharedPreference().setPassword(password);
    final bool resultoken = await SharedPreference().setToken(token);
    final bool resultuserId = await SharedPreference().setUserId(userId);
    if (loginResponseDataModel!.value!.profilecreated == false) {
      navigateToCreateProfileScreen(context);
    } else {
      // navigateToHomeScreen(context);
      navigateToPresentReserveScreen(context);
    }
  }

  navigateToPresentReserveScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PresentReservationScreen()),
        (Route<dynamic> route) => false);
  }

  navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PresentReservationScreen()),
        (Route<dynamic> route) => false);
  }

  navigateToProfileScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          title: 'Profile',
          titlechange: false,
        ),
      ),
    );
  }

  clearData() {
    email.clear();
    password.clear();
  }

  navigateToCreateProfileScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => CreateProfileScreen()),
        (Route<dynamic> route) => false);
  }

  togglePassword(isPasswordVisible) {
    _isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
