import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/math_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-up-account-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/email-verification.dart';
import '../Core/utils/image_constant.dart';
import '../theme/app_decoration.dart';
import '../theme/app_style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool emailvalid = false;
  bool passhint = false;

  /* Validating Email Function */
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
        final auth = Provider.of<CreateAccountProvider>(context, listen: false);
        auth.clearData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateAccountProvider>(builder: (context, object, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.black900,
          appBar: AppBar(
            backgroundColor: ColorConstant.black900,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorConstant.amberA700,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: SizedBox(
            width: size.width,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: ColorConstant.black900,
              ),
              child: ListView(
                physics:const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        130.00,
                      ),
                      top: getVerticalSize(
                        88.00,
                      ),
                      right: getHorizontalSize(
                        130.00,
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
                      fit: BoxFit.contain,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    39.00,
                                  ),
                                  top: getVerticalSize(
                                    37.00,
                                  ),
                                  right: getHorizontalSize(
                                    39.00,
                                  ),
                                ),
                                child: Text(
                                  createAccount,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylerobotoromanlight24
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
                                  33.00,
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
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          30.00,
                                        ),
                                      ),
                                      borderSide: BorderSide(
                                        color: ColorConstant.bluegray100,
                                        width: 1,
                                      ),
                                    ),
                                    enabled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          30.00,
                                        ),
                                      ),
                                      borderSide: BorderSide(
                                        color: ColorConstant.amberA700,
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
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: getSize(
                                        24.00,
                                      ),
                                      minHeight: getSize(
                                        24.00,
                                      ),
                                    ),
                                    suffixIcon: Visibility(
                                      visible: object.email.text.isEmpty
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
                                    suffixIconConstraints: BoxConstraints(
                                      minWidth: getSize(
                                        24.00,
                                      ),
                                      minHeight: getSize(
                                        24.00,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: ColorConstant.whiteA700,
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
                                  33.00,
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
                                      object.isPasswordVisible ? true : false,
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
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          30.00,
                                        ),
                                      ),
                                      borderSide: BorderSide(
                                        color: ColorConstant.bluegray100,
                                        width: 1,
                                      ),
                                    ),
                                    enabled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          30.00,
                                        ),
                                      ),
                                      borderSide: BorderSide(
                                        color: ColorConstant.amberA700,
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
                                    prefixIconConstraints: BoxConstraints(
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
                                          child: object.isPasswordVisible
                                              ? SvgPicture.asset(
                                                  ImageConstant.imgEyeoff,
                                                  fit: BoxFit.contain,
                                                )
                                              : SvgPicture.asset(
                                                  ImageConstant.imgEye,
                                                  fit: BoxFit.contain,
                                                ),
                                          onTap: () {
                                            object.togglePassword(
                                                object.isPasswordVisible);
                                          },
                                        ),
                                      ),
                                    ),
                                    suffixIconConstraints: BoxConstraints(
                                      minWidth: getSize(
                                        24.00,
                                      ),
                                      minHeight: getSize(
                                        24.00,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: ColorConstant.whiteA700,
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
                                  3.00,
                                ),
                                top: getVerticalSize(
                                  33.00,
                                ),
                                right: getHorizontalSize(
                                  16.00,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: getVerticalSize(
                                      60.00,
                                    ),
                                    width: getHorizontalSize(
                                      350.00,
                                    ),
                                    child: TextFormField(
                                      controller: object.confirmPassword,
                                      obscureText:
                                          object.isConfirmPasswordVisible
                                              ? true
                                              : false,
                                      decoration: InputDecoration(
                                        hintText: confirmPassword,
                                        hintStyle: AppStyle
                                            .textstylerobotoromanregular18
                                            .copyWith(
                                          fontSize: getFontSize(
                                            18.0,
                                          ),
                                          color: ColorConstant.gray900,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            getHorizontalSize(
                                              30.00,
                                            ),
                                          ),
                                          borderSide: BorderSide(
                                            color: ColorConstant.bluegray100,
                                            width: 1,
                                          ),
                                        ),
                                        enabled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            getHorizontalSize(
                                              30.00,
                                            ),
                                          ),
                                          borderSide: BorderSide(
                                            color: ColorConstant.amberA700,
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
                                        prefixIconConstraints: BoxConstraints(
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
                                                      .isConfirmPasswordVisible
                                                  ? SvgPicture.asset(
                                                      ImageConstant.imgEyeoff,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : SvgPicture.asset(
                                                      ImageConstant.imgEye,
                                                      fit: BoxFit.contain,
                                                    ),
                                              onTap: () {
                                                object.toggleConfirmPasswordVisible(
                                                    object
                                                        .isConfirmPasswordVisible);
                                              },
                                            ),
                                          ),
                                        ),
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth: getSize(
                                            24.00,
                                          ),
                                          minHeight: getSize(
                                            24.00,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: ColorConstant.whiteA700,
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(
                                        7.00,
                                      ),
                                      top: getVerticalSize(
                                        18.00,
                                      ),
                                      bottom: getVerticalSize(
                                        18.00,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: (() {
                                        setState(() {
                                          warningDialogs(
                                              context, passwordWarningText);
                                        });
                                      }),
                                      child: SizedBox(
                                        height: getSize(
                                          24.00,
                                        ),
                                        width: getSize(
                                          24.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgAlertcircle,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                      object.createUser(context);
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            39.00,
                                          ),
                                          top: getVerticalSize(
                                            48.00,
                                          ),
                                          right: getHorizontalSize(
                                            39.00,
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
                                            signUp.toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylerobotoromansemibold16
                                                .copyWith(
                                              fontSize: getFontSize(
                                                16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    39.00,
                                  ),
                                  top: getVerticalSize(
                                    44.00,
                                  ),
                                  right: getHorizontalSize(
                                    39.00,
                                  ),
                                  bottom: getVerticalSize(
                                    40.00,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      alreadyhaveanaccount,
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
                                        color: ColorConstant.black900,
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (() => {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            const SignInScreen()),
                                                    (Route<dynamic> route) =>
                                                        false)
                                          }),
                                      child: Text(
                                        signIn,
                                        style: TextStyle(
                                          color: ColorConstant.amberA700,
                                          fontSize: getFontSize(
                                            16,
                                          ),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
