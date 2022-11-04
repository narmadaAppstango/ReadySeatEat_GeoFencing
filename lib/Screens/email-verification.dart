import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/image_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/email-verification-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-up-account-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-Up-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/email-confirmed-screen.dart';
import 'package:restaurent_seating_mobile_frontend/main.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_decoration.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_style.dart';

import '../Core/utils/widgets/warning-dialogs.dart';
import '../core/utils/math_utils.dart';

class ConfirmYourEmailScreen extends StatefulWidget {
  ConfirmYourEmailScreen(this.email, this.page, {Key? key}) : super(key: key);
  final String email;
  final String page;
  @override
  _ConfirmYourEmailState createState() => _ConfirmYourEmailState();
}

class _ConfirmYourEmailState extends State<ConfirmYourEmailScreen> {
  StreamController<ErrorAnimationType>? errorController;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  

  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  bool _isrunning = false;

  Timer? _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  _loadInitial()
  {
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
    });
  }

  /* Timer function to rerouting to another screen */

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
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

  /* Dispose method to cancel when the screen closed */

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailVerificationProvider>(
        builder: (context, object, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.black900,
          body: SizedBox(
            width: size.width,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: ColorConstant.black900,
              ),
              child: ListView(
                physics: const ClampingScrollPhysics(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  31.00,
                                ),
                                top: getVerticalSize(
                                  37.00,
                                ),
                                right: getHorizontalSize(
                                  31.00,
                                ),
                              ),
                              child: Text(
                                confirmyourmail,
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
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: getHorizontalSize(
                                351.00,
                              ),
                              margin: EdgeInsets.only(
                                left: getHorizontalSize(
                                  31.00,
                                ),
                                top: getVerticalSize(
                                  31.00,
                                ),
                                right: getHorizontalSize(
                                  31.00,
                                ),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: sentmailText + ' ',
                                      style: TextStyle(
                                        color: ColorConstant.black900,
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.email.toString(),
                                      style: TextStyle(
                                        color: ColorConstant.black900,
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: getHorizontalSize(
                                350.00,
                              ),
                              margin: EdgeInsets.only(
                                left: getHorizontalSize(
                                  31.00,
                                ),
                                top: getVerticalSize(
                                  35.00,
                                ),
                                right: getHorizontalSize(
                                  30.00,
                                ),
                              ),
                              child: Text(
                                checkmailtext,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: AppStyle.textstylerobotoromanregular14
                                    .copyWith(
                                  fontSize: getFontSize(
                                    14,
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
                                  31.00,
                                ),
                                top: getVerticalSize(
                                  26.00,
                                ),
                                right: getHorizontalSize(
                                  31.00,
                                ),
                              ),
                              child: Text(
                                confirmationCode,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppStyle.textstylerobotoromanmedium18
                                    .copyWith(
                                  fontSize: getFontSize(
                                    18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 30),
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
                                  errorAnimationController: errorController,
                                  controller: object.otp,
                                  autoDisposeControllers: false,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    debugPrint(value);
                                    setState(() {});
                                  },
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: getHorizontalSize(
                                350.00,
                              ),
                              margin: EdgeInsets.only(
                                left: getHorizontalSize(
                                  31.00,
                                ),
                                top: getVerticalSize(
                                  2.00,
                                ),
                                right: getHorizontalSize(
                                  31.00,
                                ),
                              ),
                              child: Column(children: [
                                Text(
                                  notseentheCode,
                                  style: TextStyle(
                                    color: ColorConstant.gray700,
                                    fontSize: getFontSize(
                                      13,
                                    ),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      notyourmailText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorConstant.gray700,
                                        fontSize: getFontSize(
                                          13,
                                        ),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    _isrunning == true
                                        ? Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Resend in',
                                                    style: TextStyle(
                                                        color: ColorConstant
                                                            .amberA700),
                                                  ),
                                                  Text(' $_start '),
                                                  Text(
                                                    'Sec',
                                                    style: TextStyle(
                                                        color: ColorConstant
                                                            .amberA700),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              startTimer();
                                              _isrunning = true;
                                              object.resendEmail(
                                                  context, widget.email);
                                            },
                                            child: Text(
                                              ' ' + resendCode,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ColorConstant.black900,
                                                fontSize: getFontSize(
                                                  14,
                                                ),
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                          object.status == Status.authenticating
                              ? Center(
                                  child: SizedBox(
                                    child:
                                        Lottie.asset("assets/loading-rs.json"),
                                    width: 80,
                                    height: 80,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    object.verifyEmail(context, widget.email);
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          39.00,
                                        ),
                                        top: getVerticalSize(
                                          25.00,
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
                                          continueText.toUpperCase(),
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
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignInScreen()),
                                  (route) => false);
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    31.00,
                                  ),
                                  top: getVerticalSize(
                                    30.00,
                                  ),
                                  right: getHorizontalSize(
                                    31.00,
                                  ),
                                  bottom: getVerticalSize(
                                    40.00,
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
