import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/image_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/math_utils.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/forget-password-provider.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_decoration.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_style.dart';

import '../Core/utils/widgets/warning-dialogs.dart';

class ForgotPasswordChangeScreen extends StatefulWidget {
  const ForgotPasswordChangeScreen(this.email, {Key? key}) : super(key: key);
  final String email;
  @override
  State<ForgotPasswordChangeScreen> createState() =>
      _ForgotPasswordChangeScreenState();
}

class _ForgotPasswordChangeScreenState
    extends State<ForgotPasswordChangeScreen> {
  final formKey = GlobalKey<FormState>();
  bool _isrunning = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = 30;
            _isrunning = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

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
        final auth =
            Provider.of<ForgetPasswordProvider>(context, listen: false);
        auth.cleardata();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgetPasswordProvider>(builder: (context, object, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.black900,
          body: Container(
            decoration: BoxDecoration(
              color: ColorConstant.black900,
            ),
            child: ListView(
              physics:const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: getHorizontalSize(
                      124.00,
                    ),
                    right: getHorizontalSize(
                      124.00,
                    ),
                  ),
                  child: Text(
                    "Forgot Password",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.textstylerobotoromanlight241.copyWith(
                      fontSize: getFontSize(
                        24,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: double.infinity,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(
                                38.00,
                              ),
                              top: getVerticalSize(
                                57.00,
                              ),
                              right: getHorizontalSize(
                                38.00,
                              ),
                            ),
                            child: SizedBox(
                              height: getSize(
                                220.00,
                              ),
                              width: getSize(
                                220.00,
                              ),
                              child: SvgPicture.asset(
                                ImageConstant.imgGroup161,
                                fit: BoxFit.fill,
                              ),
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
                                35.00,
                              ),
                              right: getHorizontalSize(
                                38.00,
                              ),
                            ),
                            child: Text(
                              forgotPassCodeText + ' ' + widget.email,
                              maxLines: null,
                              textAlign: TextAlign.center,
                              style: AppStyle.textstylerobotoromanregular161
                                  .copyWith(
                                fontSize: getFontSize(
                                  16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Form(
                            key: formKey,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 40),
                                child: PinCodeTextField(
                                  appContext: context,
                                  backgroundColor: Colors.transparent,
                                  length: 6,
                                  obscureText: true,
                                  obscuringCharacter: '*',
                                  obscuringWidget: Image.asset(
                                    'assets/images/star.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  blinkWhenObscuring: true,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    activeColor: const Color.fromARGB(
                                        255, 243, 239, 239),
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(15),
                                    fieldHeight: 40,
                                    fieldWidth: 40,
                                    inactiveColor: const Color.fromARGB(
                                        255, 243, 239, 239),
                                    errorBorderColor: const Color.fromARGB(
                                        255, 243, 239, 239),
                                    inactiveFillColor: const Color.fromARGB(
                                        255, 243, 239, 239),
                                    activeFillColor: const Color.fromARGB(
                                        255, 233, 229, 229),
                                    selectedColor: const Color.fromARGB(
                                        255, 243, 239, 239),
                                    selectedFillColor: const Color.fromARGB(
                                        255, 243, 239, 239),
                                  ),
                                  cursorColor: Colors.black,
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  controller: object.otp,
                                  keyboardType: TextInputType.number,
                                  autoDisposeControllers: false,
                                  onChanged: (value) {
                                    debugPrint(value);
                                    setState(() {});
                                  },
                                )),
                          ),
                        ),
                        _isrunning == true
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      230.00,
                                    ),
                                    top: getVerticalSize(
                                      7.00,
                                    ),
                                    right: getHorizontalSize(
                                      30.00,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Resend in',
                                        style: TextStyle(
                                            color: ColorConstant.amberA700),
                                      ),
                                      Text(' $_start '),
                                      Text(
                                        'Sec',
                                        style: TextStyle(
                                            color: ColorConstant.amberA700),
                                      ),
                                    ],
                                  ),
                                ))
                            : GestureDetector(
                                onTap: () {
                                  startTimer();
                                  _isrunning = true;
                                  object.resendCode(context, widget.email);
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(
                                        230.00,
                                      ),
                                      top: getVerticalSize(
                                        7.00,
                                      ),
                                      right: getHorizontalSize(
                                        30.00,
                                      ),
                                    ),
                                    child: Text(
                                      resendCode.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .textstylerobotoromanmedium16
                                          .copyWith(
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                      ),
                                    ),
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
                                25.00,
                              ),
                              right: getHorizontalSize(
                                38.00,
                              ),
                            ),
                            child: Text(
                              passDiffText,
                              maxLines: null,
                              textAlign: TextAlign.center,
                              style: AppStyle.textstylerobotoromanregular161
                                  .copyWith(
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
                              40.00,
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
                              obscureText: object.isPasswordVisible,
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
                                  child: Lottie.asset("assets/loading-rs.json"),
                                  width: 100,
                                  height: 100,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  object.resetPassword(
                                      context, widget.email.trim());
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
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
                                        resetpassword.toUpperCase(),
                                        textAlign: TextAlign.center,
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
                                  20.00,
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
                                  textAlign: TextAlign.center,
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
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
