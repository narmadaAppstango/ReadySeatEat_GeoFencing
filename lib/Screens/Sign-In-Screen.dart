import 'dart:async';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-in-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-Up-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/forget-password-screen.dart';
import 'dart:io' show Platform;
import '../Core/utils/image_constant.dart';
import '../Core/utils/math_utils.dart';
import '../Core/utils/widgets/warning-dialogs.dart';
import '../theme/app_decoration.dart';
import '../theme/app_style.dart';

class SignInScreen extends StatefulWidget {
  //final FacebookLogin plugin;
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool emailvalid = false;

  /* Validating email */
  void isValidEmail(String value) {
    setState(() {
      bool isvalid = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value);
      if (isvalid == true) {
        emailvalid = true;
      } else {
        emailvalid = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
    
  /* Load datas into the screen initial stage */

  _loadInitial() async {
    setState(() {
    //   _connectivitySubscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //     warningDialogs(context, 'You are currently offline.');
    //   } else {
    //     warningDialogs(context, 'Your internet connection has been rstored.');
    //   }
    //   // Got a new connectivity status!
    // });
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        final auth = Provider.of<SigninProvider>(context, listen: false);
        auth.clearData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SigninProvider>(builder: (context, object, child) {
      return BlurryModalProgressHUD(
          inAsyncCall: object.isLoading,
          blurEffectIntensity: 4,
          progressIndicator: SpinKitFadingCircle(
            color: Colors.grey[700],
            size: 90.0,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Colors.black87,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: ColorConstant.black900,
              body: SizedBox(
                width: size.width,
                height: size.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.black900,
                  ),
                  child: ListView(
                    physics:const ClampingScrollPhysics(),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.black900,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    139.00,
                                  ),
                                  top: getVerticalSize(
                                    88.00,
                                  ),
                                  right: getHorizontalSize(
                                    139.00,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icon/logos.svg",
                                  height: getVerticalSize(  
                                    160,
                                  ),
                                  width: getHorizontalSize(
                                    100.00,
                                  ),
                                  //fit: BoxFit.fill,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                    top: getVerticalSize(
                                      75.61,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.gray50,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        getHorizontalSize(
                                          50.00,
                                        ),
                                      ),
                                      topRight: Radius.circular(
                                        getHorizontalSize(
                                          50.00,
                                        ),
                                      ),
                                      bottomLeft: Radius.circular(
                                        getHorizontalSize(
                                          0.00,
                                        ),
                                      ),
                                      bottomRight: Radius.circular(
                                        getHorizontalSize(
                                          0.00,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              37.00,
                                            ),
                                            top: getVerticalSize(
                                              37.00,
                                            ),
                                            right: getHorizontalSize(
                                              37.00,
                                            ),
                                          ),
                                          child: Text(
                                            signIn,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylerobotoromanlight24
                                                .copyWith(
                                              fontSize: getFontSize(
                                                24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            39.00,
                                          ),
                                          top: getVerticalSize(
                                            33.00,
                                          ),
                                          right: getHorizontalSize(
                                            39.00,
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: getVerticalSize(
                                            60.00,
                                          ),
                                          width: getHorizontalSize(
                                            350.00,
                                          ),
                                          child: TextFormField(
                                            controller: object.email,
                                            onChanged: (value) {
                                              value = object.email.text;
                                              isValidEmail(value);
                                            },
                                            onFieldSubmitted: (value) {
                                              value = object.email.text;
                                              isValidEmail(value);
                                            },
                                            decoration: InputDecoration(
                                              hintText: email,
                                              hintStyle: AppStyle
                                                  .textstylerobotoromanregular18
                                                  .copyWith(
                                                fontSize: getFontSize(
                                                  18.0,
                                                ),
                                                color: ColorConstant.gray900,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(
                                                    30.00,
                                                  ),
                                                ),
                                                borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.bluegray100,
                                                  width: 1,
                                                ),
                                              ),
                                              enabled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(
                                                    30.00,
                                                  ),
                                                ),
                                                borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.amberA700,
                                                  width: 1,
                                                ),
                                              ),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    15.00,
                                                  ),
                                                  right: getHorizontalSize(
                                                    10.00,
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: getSize(
                                                    24.00,
                                                  ),
                                                  width: getSize(
                                                    24.00,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    ImageConstant.imgMail,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              prefixIconConstraints:
                                                  BoxConstraints(
                                                minWidth: getSize(
                                                  24.00,
                                                ),
                                                minHeight: getSize(
                                                  24.00,
                                                ),
                                              ),
                                              suffixIcon: Visibility(
                                                visible:
                                                    object.email.text.isEmpty
                                                        ? false
                                                        : emailvalid,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      10.00,
                                                    ),
                                                    right: getHorizontalSize(
                                                      18.00,
                                                    ),
                                                  ),
                                                  child: SizedBox(
                                                    height: getSize(
                                                      24.00,
                                                    ),
                                                    width: getSize(
                                                      24.00,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      ImageConstant.imgCheck,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              suffixIconConstraints:
                                                  BoxConstraints(
                                                minWidth: getSize(
                                                  24.00,
                                                ),
                                                minHeight: getSize(
                                                  24.00,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  ColorConstant.whiteA700,
                                              isDense: true,
                                              contentPadding: EdgeInsets.only(
                                                top: getVerticalSize(
                                                  20.16,
                                                ),
                                                bottom: getVerticalSize(
                                                  19.16,
                                                ),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: ColorConstant.gray900,
                                              fontSize: getFontSize(
                                                18.0,
                                              ),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            39.00,
                                          ),
                                          top: getVerticalSize(
                                            33.00,
                                          ),
                                          right: getHorizontalSize(
                                            39.00,
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: getVerticalSize(
                                            60.00,
                                          ),
                                          width: getHorizontalSize(
                                            350.00,
                                          ),
                                          child: TextFormField(
                                            controller: object.password,
                                            obscureText:
                                                object.isPasswordVisible
                                                    ? true
                                                    : false,
                                            decoration: InputDecoration(
                                              hintText: password,
                                              hintStyle: AppStyle
                                                  .textstylerobotoromanregular18
                                                  .copyWith(
                                                fontSize: getFontSize(
                                                  18.0,
                                                ),
                                                color: ColorConstant.gray900,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(
                                                    30.00,
                                                  ),
                                                ),
                                                borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.bluegray100,
                                                  width: 1,
                                                ),
                                              ),
                                              enabled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(
                                                    30.00,
                                                  ),
                                                ),
                                                borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.amberA700,
                                                  width: 1,
                                                ),
                                              ),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    15.00,
                                                  ),
                                                  right: getHorizontalSize(
                                                    10.00,
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: getSize(
                                                    24.00,
                                                  ),
                                                  width: getSize(
                                                    24.00,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    ImageConstant.imgLock,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              prefixIconConstraints:
                                                  BoxConstraints(
                                                minWidth: getSize(
                                                  24.00,
                                                ),
                                                minHeight: getSize(
                                                  24.00,
                                                ),
                                              ),
                                              suffixIcon: Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    10.00,
                                                  ),
                                                  right: getHorizontalSize(
                                                    18.00,
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: getSize(
                                                    24.00,
                                                  ),
                                                  width: getSize(
                                                    24.00,
                                                  ),
                                                  child: GestureDetector(
                                                    child: object
                                                            .isPasswordVisible
                                                        ? SvgPicture.asset(
                                                            ImageConstant
                                                                .imgEyeoff,
                                                            fit: BoxFit.contain,
                                                          )
                                                        : SvgPicture.asset(
                                                            ImageConstant
                                                                .imgEye,
                                                            fit: BoxFit.contain,
                                                          ),
                                                    onTap: () {
                                                      object.togglePassword(object
                                                          .isPasswordVisible);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              suffixIconConstraints:
                                                  BoxConstraints(
                                                minWidth: getSize(
                                                  24.00,
                                                ),
                                                minHeight: getSize(
                                                  24.00,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  ColorConstant.whiteA700,
                                              isDense: true,
                                              contentPadding: EdgeInsets.only(
                                                top: getVerticalSize(
                                                  20.16,
                                                ),
                                                bottom: getVerticalSize(
                                                  19.16,
                                                ),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: ColorConstant.gray900,
                                              fontSize: getFontSize(
                                                18.0,
                                              ),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (() => {
                                              setState(() {
                                                object.email.clear();
                                                object.password.clear();
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const ForgotPasswordSentScreen()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            true);
                                              })
                                            }),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                220.00,
                                              ),
                                              top: getVerticalSize(
                                                21.00,
                                              ),
                                              right: getHorizontalSize(
                                                40.00,
                                              ),
                                            ),
                                            child: Text(
                                              forgetpassword,
                                              //overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .textstylerobotoromansemibold14
                                                  .copyWith(
                                                fontSize: getFontSize(
                                                  17,
                                                ),
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      object.status == Status.authenticating
                                          ? Center(
                                              child: SizedBox(
                                                child: Lottie.asset(
                                                    "assets/loading-rs.json"),
                                                width: 100,
                                                height: 100,
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  object.doLogin(context);
                                                });
                                              },
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      37.00,
                                                    ),
                                                    top: getVerticalSize(
                                                      21.00,
                                                    ),
                                                    right: getHorizontalSize(
                                                      37.00,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: getVerticalSize(
                                                      60.00,
                                                    ),
                                                    width: getHorizontalSize(
                                                      350.00,
                                                    ),
                                                    decoration: AppDecoration
                                                        .textstylerobotoromansemibold16,
                                                    child: Text(
                                                      signIn.toUpperCase(),
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .textstylerobotoromansemibold16
                                                          .copyWith(
                                                              fontSize:
                                                                  getFontSize(
                                                                16,
                                                              ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                              37.00,
                                            ),
                                            top: getVerticalSize(
                                              16.00,
                                            ),
                                            right: getHorizontalSize(
                                              37.00,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                height: getVerticalSize(
                                                  1.00,
                                                ),
                                                width: getHorizontalSize(
                                                  148.00,
                                                ),
                                                margin: EdgeInsets.only(
                                                  top: getVerticalSize(
                                                    15.00,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    8.00,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: ColorConstant.black900,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      18.00,
                                                    ),
                                                    top: 5),
                                                child: Text(
                                                  'OR',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .textstylerobotoromansemibold161
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: getVerticalSize(
                                                  1.00,
                                                ),
                                                width: getHorizontalSize(
                                                  148.00,
                                                ),
                                                margin: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    12.00,
                                                  ),
                                                  top: getVerticalSize(
                                                    15.00,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    8.00,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: ColorConstant.black900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Platform.isAndroid
                                          ? object.status ==
                                                  Status.authenticating
                                              ? Center(
                                                  child: SizedBox(
                                                    child: Lottie.asset(
                                                        "assets/loading-rs.json"),
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      print(object.isclicked);
                                                      if (object.isclicked ==
                                                          true) {
                                                        object.isclicked =
                                                            false;
                                                        object.socialSignIn(
                                                            context,
                                                            'facebook');
                                                      }
                                                    });
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      height: getSize(
                                                        48.00,
                                                      ),
                                                      width: getSize(
                                                        48.00,
                                                      ),
                                                      child: SvgPicture.asset(
                                                        ImageConstant
                                                            .imgFacebook,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                          : object.status ==
                                                  Status.authenticating
                                              ? Center(
                                                  child: SizedBox(
                                                    child: Lottie.asset(
                                                        "assets/loading-rs.json"),
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          print(
                                                              object.isclicked);
                                                          if (object
                                                                  .isclicked ==
                                                              true) {
                                                            object.isclicked =
                                                                false;
                                                            object.socialSignIn(
                                                                context,
                                                                'facebook');
                                                          }
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                            140.00,
                                                          ),
                                                          top: getVerticalSize(
                                                            22.00,
                                                          ),
                                                          right:
                                                              getHorizontalSize(
                                                            20.00,
                                                          ),
                                                        ),
                                                        child: Container(
                                                          height: getSize(
                                                            48.00,
                                                          ),
                                                          width: getSize(
                                                            48.00,
                                                          ),
                                                          child:
                                                              SvgPicture.asset(
                                                            ImageConstant
                                                                .imgFacebook,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          print(
                                                              object.isclicked);
                                                          if (object
                                                                  .isclicked ==
                                                              true) {
                                                            object.isclicked =
                                                                false;
                                                            object.socialSignIn(
                                                                context,
                                                                'apple');
                                                          }
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                            40.00,
                                                          ),
                                                          top: getVerticalSize(
                                                            22.00,
                                                          ),
                                                          right:
                                                              getHorizontalSize(
                                                            20.00,
                                                          ),
                                                        ),
                                                        child: Container(
                                                          height: getSize(
                                                            48.00,
                                                          ),
                                                          width: getSize(
                                                            48.00,
                                                          ),
                                                          child: Image.asset(
                                                            'assets/apple.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              37.00,
                                            ),
                                            top: getVerticalSize(
                                              32.00,
                                            ),
                                            right: getHorizontalSize(
                                              37.00,
                                            ),
                                            bottom: getVerticalSize(
                                              42.00,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                newhere,
                                                style: TextStyle(
                                                  color: ColorConstant.gray400,
                                                  fontSize: getFontSize(
                                                    16,
                                                  ),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                ' ',
                                                style: TextStyle(
                                                  color: ColorConstant.gray400,
                                                  fontSize: getFontSize(
                                                    16,
                                                  ),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (() {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  const SignUpScreen()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              true);
                                                }),
                                                child: Text(
                                                  createAccount,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.black900,
                                                    fontSize: getFontSize(
                                                      16,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
