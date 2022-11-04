import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/image_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/math_utils.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/forget-password-provider.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_decoration.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_style.dart';

import '../Core/utils/widgets/warning-dialogs.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  /* Use for Calling the initial calling before screen loads function */
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
    // });
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        final auth =
            Provider.of<ForgetPasswordProvider>(context, listen: false);
        auth.clearData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgetPasswordProvider>(builder: (context, object, child) {
      return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Container(
              color: Colors.black,
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: Text(
                        'Change Password',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.textstylerobotoromanlight241.copyWith(
                          fontSize: getFontSize(
                            22,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: getVerticalSize(
                          23.00,
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
                        ),
                      ),
                      //color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(
                                38.00,
                              ),
                              top: getVerticalSize(
                                65.00,
                              ),
                              right: getHorizontalSize(
                                38.00,
                              ),
                            ),
                            child: SizedBox(
                              height: getSize(
                                200.00,
                              ),
                              width: getSize(
                                200.00,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/lockimage.svg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: getHorizontalSize(
                                351.00,
                              ),
                              margin: EdgeInsets.only(
                                left: getHorizontalSize(
                                  38.00,
                                ),
                                top: getVerticalSize(
                                  30.00,
                                ),
                                right: getHorizontalSize(
                                  38.00,
                                ),
                              ),
                              child: Text(
                                changepasswordMessage,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: AppStyle.textstylerobotoromanregular161
                                    .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: getFontSize(
                                    16,
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
                                50.00,
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
                                controller: object.oldpassword,
                                obscureText: object.isoldPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: currentPassword,
                                  hintStyle: AppStyle
                                      .textstylerobotoromanregular16
                                      .copyWith(
                                    fontSize: getFontSize(
                                      16.0,
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
                                  focusedBorder: OutlineInputBorder(
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
                                        ImageConstant.imgLock3,
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
                                        30.00,
                                      ),
                                      width: getSize(
                                        30.00,
                                      ),
                                      child: GestureDetector(
                                        child: object.isoldPasswordVisible
                                            ? SvgPicture.asset(
                                                ImageConstant.imgEyeoff,
                                                fit: BoxFit.contain,
                                              )
                                            : SvgPicture.asset(
                                                ImageConstant.imgEye,
                                                fit: BoxFit.contain,
                                              ),
                                        onTap: () {
                                          object.toggleOldPasswordVisible(
                                              object.isoldPasswordVisible);
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
                                      19.98,
                                    ),
                                    bottom: getVerticalSize(
                                      18.98,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: ColorConstant.gray900,
                                  fontSize: getFontSize(
                                    16.0,
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
                                32.00,
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
                                decoration: InputDecoration(
                                  hintText: newpassText,
                                  hintStyle: AppStyle
                                      .textstylerobotoromanregular16
                                      .copyWith(
                                    fontSize: getFontSize(
                                      16.0,
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
                                  focusedBorder: OutlineInputBorder(
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
                                        ImageConstant.imgLock4,
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
                                        30.00,
                                      ),
                                      width: getSize(
                                        30.00,
                                      ),
                                      child: GestureDetector(
                                        child: object.isPasswordVisible
                                            ? SvgPicture.asset(
                                                ImageConstant.imgEyeoff,
                                                fit: BoxFit.fill,
                                              )
                                            : SvgPicture.asset(
                                                ImageConstant.imgEye,
                                                fit: BoxFit.fill,
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
                                      19.98,
                                    ),
                                    bottom: getVerticalSize(
                                      18.98,
                                    ),
                                  ),
                                ),
                                obscureText: object.isPasswordVisible,
                                style: TextStyle(
                                  color: ColorConstant.gray900,
                                  fontSize: getFontSize(
                                    16.0,
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
                                32.00,
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
                                controller: object.confirmPassword,
                                decoration: InputDecoration(
                                  hintText: confirmnewpassText,
                                  hintStyle: AppStyle
                                      .textstylerobotoromanregular16
                                      .copyWith(
                                    fontSize: getFontSize(
                                      16.0,
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
                                  focusedBorder: OutlineInputBorder(
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
                                        ImageConstant.imgLock4,
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
                                        30.00,
                                      ),
                                      width: getSize(
                                        30.00,
                                      ),
                                      child: GestureDetector(
                                        child: object.isConfirmPasswordVisible
                                            ? SvgPicture.asset(
                                                ImageConstant.imgEyeoff,
                                                fit: BoxFit.fill,
                                              )
                                            : SvgPicture.asset(
                                                ImageConstant.imgEye,
                                                fit: BoxFit.fill,
                                              ),
                                        onTap: () {
                                          object.toggleConfirmPasswordVisible(
                                              object.isConfirmPasswordVisible);
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
                                      19.98,
                                    ),
                                    bottom: getVerticalSize(
                                      18.98,
                                    ),
                                  ),
                                ),
                                obscureText: object.isConfirmPasswordVisible,
                                style: TextStyle(
                                  color: ColorConstant.gray900,
                                  fontSize: getFontSize(
                                    16.0,
                                  ),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          object.status == Status.authenticating
                              ? Center(
                                  child: SizedBox(
                                    child:
                                        Lottie.asset("assets/loading-rs.json"),
                                    width: 100,
                                    height: 100,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    object.changePassword(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(
                                        38.00,
                                      ),
                                      top: getVerticalSize(
                                        34.00,
                                      ),
                                      right: getHorizontalSize(
                                        38.00,
                                      ),
                                      bottom: getVerticalSize(
                                        10.00,
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
                                        'Update Password'.toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .textstylerobotoromansemibold16
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: getFontSize(
                                            16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    31.00,
                                  ),
                                  top: getVerticalSize(
                                    10.00,
                                  ),
                                  right: getHorizontalSize(
                                    31.00,
                                  ),
                                  bottom: getVerticalSize(
                                    30.00,
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
                                      .textstylerobotoromansemibold163,
                                  child: Text(
                                    goBackText.toUpperCase(),
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .textstylerobotoromansemibold163
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
