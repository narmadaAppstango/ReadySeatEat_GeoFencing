import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/extensions.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/math_utils.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/api-service-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-in-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/edit-profile-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/home-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import 'package:restaurent_seating_mobile_frontend/model/SocialLoginResponseModel.dart';
import 'package:restaurent_seating_mobile_frontend/model/common-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/login-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_style.dart';

import '../Core/utils/color_constant.dart';
import '../Core/utils/image_constant.dart';
import '../Core/utils/widgets/app-utils-loader.dart';
import '../Screens/Sign-In-Screen.dart';

class CreateProfileProvider extends ChangeNotifier {
  Status _status = Status.unauthenticated;

  Status get status => _status;

  final TextEditingController? _email = TextEditingController();

  TextEditingController? get email => _email;

  final TextEditingController? _firstName = TextEditingController();

  TextEditingController? get firstName => _firstName;

  final TextEditingController? _lastName = TextEditingController();

  TextEditingController? get lastName => _lastName;

  final TextEditingController? _middleName = TextEditingController();

  TextEditingController? get middleName => _middleName;

  final TextEditingController? _phoneNo = TextEditingController();

  TextEditingController? get phoneNo => _phoneNo;

  final bool _isValidEmailReceived = true;

  bool get isValidEmailReceived => _isValidEmailReceived;

  File _imagePickedFile = File('');

  File get imagePickedFile => _imagePickedFile;

  var _image = "";
  String get image => _image;

  var _profileImage = "";
  String get profileImage => _profileImage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool isclicked = true;

  bool isload = false;

  CommonResponseDataModel? _commonResponseDataModel;

  CommonResponseDataModel? get commonresponseModel => _commonResponseDataModel;

  LoginResponseModel? _loginDataModel;

  LoginResponseModel? get loginDataModel => _loginDataModel;

  SocialLoginResponse? _socialResponseDataModel;
  SocialLoginResponse? get socialResponseDataModel => _socialResponseDataModel;

  /* Get Acess token of current user */
  void getAccessToken(BuildContext context, mode) async {
    var email = await SharedPreference().getemail();
    var password = await SharedPreference().getPassword();
    notifyListeners();
    _loginDataModel =
        await Provider.of<APIServiceProvider>(context, listen: false)
            .userLoginApi(email.toString().trim(), password.toString().trim());
    print(_loginDataModel!.toJson().toString());
    if (_loginDataModel?.status == false) {
      warningDialogs(context, _loginDataModel!.message);
    } else {
      final bool setToken =
          await SharedPreference().setToken(_loginDataModel!.token!);
      final bool setUserid = await SharedPreference()
          .setUserId(_loginDataModel!.value!.id!.toString());
      if (mode == 'Delete Account') {
        deleteAccount(context);
      } else {
        doProfileCreateForNewUser(context, mode, '');
      }
    }
  }

  /* Get Profile Details for current user */
  void getProfileDetails(
      BuildContext context, String mode, String logintype) async {
    var email = await SharedPreference().getemail();
    var password = await SharedPreference().getPassword();
    var netStatus = await SharedPreference().getinternetstatus();
    notifyListeners();
    if (netStatus.toString() != '') {
      if (logintype == 'true') {
        var email = await SharedPreference().getemail();
        var cognitoId = await SharedPreference().getCognitoId();
        var socialLogin = await SharedPreference().getsocialloginName();
        _isLoading = true;
        clearUserData();
        isclicked = true;
        notifyListeners();
        _socialResponseDataModel =
            await Provider.of<APIServiceProvider>(context, listen: false)
                .socialLoginapi(
                    email, socialLogin.toString(), cognitoId.toString());
        if (_loginDataModel?.status == false) {
          warningDialogs(context, _loginDataModel!.message);
        } else {
          setValueSocialFromResponse(
              _socialResponseDataModel!.user!.userDbDetails, mode);
          notifyListeners();
        }
      } else {
        _isLoading = true;
        clearUserData();
        isclicked = true;
        notifyListeners();
        _loginDataModel = await Provider.of<APIServiceProvider>(context,
                listen: false)
            .userLoginApi(email.toString().trim(), password.toString().trim());
        if (_loginDataModel?.status == false) {
          warningDialogs(context, _loginDataModel!.message);
        } else {
          setValueFromResponse(_loginDataModel!.value, mode);
          notifyListeners();
        }
      }
    } else {
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Validate Mobile function */
  bool validateMobile(String value) {
    if (phoneNo!.text.length > 10) {
      return false;
    } else {
      return true;
    }
  }

  /*   Delete User Account Api calling function */
  deleteAccountFunction(BuildContext context) async {
    var soc = await SharedPreference().getSignedin();
    if (soc.toString() != '') {
      print(soc);
      deleteAccount(context);
      notifyListeners();
    } else {
      print(soc);
      getAccessToken(context, 'Delete Account');
      notifyListeners();
    }
  }

  deleteAccount(BuildContext context) async {
    _status = Status.authenticating;
    isclicked = true;
    notifyListeners();
    var soc = await SharedPreference().getSignedin();
    var userId = await SharedPreference().getUserId();
    var netstatus = await SharedPreference().getinternetstatus();
    if (netstatus.toString() != '') {
      _commonResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .deleteaccountapi(userId.toString());
      print(_commonResponseDataModel!.toJson().toString());
      _status = Status.authenticated;
      isload = false;
      notifyListeners();
      if (_commonResponseDataModel?.status != null) {
        if (_commonResponseDataModel?.status == false) {
          warningDialogs(context, _commonResponseDataModel!.message);
        } else {
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
          final bool resusocName =
              await SharedPreference().setSocialLoginName('');
          final bool rescognitoid = await SharedPreference().setCognitoId('');
          final bool resuserId = await SharedPreference().setUserId('');
          sucessDialogs1(
              context, _commonResponseDataModel!.message, 'Delete Account', '');
        }
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

  /* Create User Profile API Validting function  */
  createUserProfile(BuildContext context, String mode, String loginType) async {
    if (firstName!.text.trim().isNotEmpty &&
        firstName!.text.trim().isValidName()) {
      if (lastName!.text.trim().isNotEmpty &&
          lastName!.text.trim().isValidName()) {
        if (phoneNo!.text.isNotEmpty &&
            phoneNo!.text.isValidPhoneNo() &&
            phoneNo!.text.trim().length == 10) {
          if (email!.text.trim().isNotEmpty) {
            if (mode == '0') {
                if (loginType == 'true') {
                  doProfileCreateForNewUser(context, mode, loginType);
                } else {
                  getAccessToken(context, mode);
                }
            } else {
              if (loginType == 'true') {
                doProfileCreateForNewUser(context, mode, loginType);
              } else {
                getAccessToken(context, mode);
              }
            }
          } else {
            isclicked = true;
            warningDialogs(context, "Email id should not be empty");
          }
        } else {
          isclicked = true;
          warningDialogs(context,
              "Phone number should not be empty or not more than 10 digits");
        }
      } else {
        isclicked = true;
        warningDialogs(context, "Last name cannot be empty or digits");
      }
    } else {
      isclicked = true;
      warningDialogs(context, "First name cannot be empty or digits");
    }
  }

  /* Create User Profile API calling function */
  doProfileCreateForNewUser(
      BuildContext context, String mode, String loginType) async {
    _status = Status.authenticating;
    isclicked = true;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _commonResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .createUserProfileApi(
                  firstName!.text,
                  middleName!.text,
                  lastName!.text,
                  phoneNo!.text,
                  imagePickedFile,
                  email!.text,
                  mode);
      _status = Status.authenticated;
      notifyListeners();
      if (_commonResponseDataModel?.status != null) {
        if (_commonResponseDataModel?.status == false) {
          _status = Status.authenticated;
          warningDialogs(context, _commonResponseDataModel!.message);
        } else {
          if (mode == '0') {
            // navigateToProfileScreen(context);
            navigateToHomeScreen(context);
          } else {
            sucessDialogs1(context, _commonResponseDataModel!.message,
                'Edit Profile', loginType);
          }
        }
      } else {
        warningDialogs(context, 'Internal server error,Please try again');
      }
    } else {
      _status = Status.unauthenticated;
      isclicked = true;
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Sucess Dialog after Edit/Create Profile */
  sucessDialogs1(BuildContext context, msg, String mode, String loginType) {
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
                WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                  final auth = Provider.of<CreateProfileProvider>(context,
                      listen: false);
                  auth.getProfileDetails(context, 'EditProfile', loginType);
                });
              } else if (mode == 'Delete Account') {
                navigateToSignInScreen(context);
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

  /* Set Pre Defined email in the create profile */
  void setEmailID(String email) async {
    _email!.text = email;
  }

  /* Set value from social login login users response */
  void setValueSocialFromResponse(UserDbDetails? data, String mode) {
    notifyListeners();
    _image = (data!.profilePicture ?? "");
    _phoneNo!.text = (data.phoneNumber ?? "");
    _email!.text = (data.email ?? "");
    _firstName!.text = (data.firstName ?? "");
    _middleName!.text = (data.middleName ?? "");
    _lastName!.text = (data.lastName ?? "");
    notifyListeners();
    if (mode == 'Profile') {
      _profileImage = 'true';
    } else {
      _profileImage = 'false';
    }
    notifyListeners();
    _isLoading = false;
  }

  /* Set value from normal login login users response */
  void setValueFromResponse(Value? data, String mode) {
    notifyListeners();
    _image = (data!.profilePicture ?? "");
    _phoneNo!.text = (data.phoneNumber ?? "");
    _email!.text = (data.email ?? "");
    _firstName!.text = (data.firstName ?? "");
    _middleName!.text = (data.middleName ?? "");
    _lastName!.text = (data.lastName ?? "");
    notifyListeners();
    if (mode == 'Profile') {
      _profileImage = 'true';
    } else {
      _profileImage = 'false';
    }
    _isLoading = false;
    notifyListeners();
  }

  /* Navigate to Home Screen */
  navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => PresentReservationScreen()),
        (Route<dynamic> route) => false);
  }

  /* Navigate to Create Profile Screen */
  navigateToProfileScreen(BuildContext context) {
    clearUserData();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) =>
                EditProfileScreen(title: 'Profile', titlechange: false)),
        (Route<dynamic> route) => false);
  }

  /* Clear Previous data*/
  clearData() {
    _firstName!.text = "";
    _lastName!.text = "";
    _middleName!.text = "";
    _phoneNo!.text = "";
    _imagePickedFile = File("");
    _image = "";
    notifyListeners();
  }

  /* Clear Old User Data */
  clearUserData() {
    _email!.text = "";
    _firstName!.text = "";
    _lastName!.text = "";
    _middleName!.text = "";
    _phoneNo!.text = "";
    _imagePickedFile = File("");
    _image = "";
    notifyListeners();
  }

  /* Pic Choose Dialog */
  void openPicChooserWindow(BuildContext context) {
    Dialogs.materialDialog(
        color: Colors.white,
        barrierColor: ColorConstant.black900,
        barrierDismissible: false,
        dialogShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        context: context,
        customView: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(children: [
              GestureDetector(
                onTap: (() {
                  Navigator.of(context, rootNavigator: true).pop();
                }),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: getHorizontalSize(
                          30.00,
                        ),
                        top: 5),
                    child: SizedBox(
                      height: getSize(
                        32.00,
                      ),
                      width: getSize(
                        32.00,
                      ),
                      child: SvgPicture.asset(
                        ImageConstant.imgXcircle,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: getHorizontalSize(
                      10.00,
                    ),
                    top: getVerticalSize(
                      4.00,
                    ),
                    right: getHorizontalSize(
                      10.00,
                    ),
                  ),
                  child: Text(
                    "Select your profile image".toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppStyle.textstylerobotoromanregular21.copyWith(
                        fontSize: getFontSize(
                          21,
                        ),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  profilePicPicker(context, false);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: getVerticalSize(
                        35.00,
                      ),
                      right: getHorizontalSize(
                        10.00,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          50.00,
                        ),
                      ),
                      border: Border.all(
                        color: ColorConstant.amberA700,
                        width: getHorizontalSize(
                          1.00,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              20.00,
                            ),
                            top: getVerticalSize(
                              19.00,
                            ),
                            bottom: getVerticalSize(
                              19.00,
                            ),
                          ),
                          child: Container(
                            height: getSize(
                              32.00,
                            ),
                            width: getSize(
                              32.00,
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.imgImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              29.00,
                            ),
                            top: getVerticalSize(
                              23.00,
                            ),
                            right: getHorizontalSize(
                              56.00,
                            ),
                            bottom: getVerticalSize(
                              23.00,
                            ),
                          ),
                          child: Text(
                            "Select from gallery",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style:
                                AppStyle.textstylerobotoromanregular21.copyWith(
                              fontSize: getFontSize(
                                20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  profilePicPicker(context, true);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: getVerticalSize(
                        26.00,
                      ),
                      right: getHorizontalSize(
                        10.00,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          50.00,
                        ),
                      ),
                      border: Border.all(
                        color: ColorConstant.amberA700,
                        width: getHorizontalSize(
                          1.00,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              21.00,
                            ),
                            top: getVerticalSize(
                              19.00,
                            ),
                            bottom: getVerticalSize(
                              19.00,
                            ),
                          ),
                          child: SizedBox(
                            height: getSize(
                              32.00,
                            ),
                            width: getSize(
                              32.00,
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.imgCamera,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              28.00,
                            ),
                            top: getVerticalSize(
                              23.00,
                            ),
                            right: getHorizontalSize(
                              76.00,
                            ),
                            bottom: getVerticalSize(
                              23.00,
                            ),
                          ),
                          child: Text(
                            "Take a picture",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.textstylerobotoromanregular201
                                .copyWith(
                              fontSize: getFontSize(
                                20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }

  /* Profile Picker function */
  void profilePicPicker(BuildContext context, bool isCameraSelected) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image from gallery or camera
    final XFile? image = await _picker.pickImage(
        source: isCameraSelected ? ImageSource.camera : ImageSource.gallery);
    _imagePickedFile = File(image!.path);
    notifyListeners();
    // image!.readAsBytes();
  }
}
