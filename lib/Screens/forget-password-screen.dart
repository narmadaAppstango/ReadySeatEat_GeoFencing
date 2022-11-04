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

class ForgotPasswordSentScreen extends StatefulWidget {
  const ForgotPasswordSentScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordSentScreenState createState() =>
      _ForgotPasswordSentScreenState();
}

class _ForgotPasswordSentScreenState extends State<ForgotPasswordSentScreen> {
  bool emailvalid = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  

  /* Email Validating Function */
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
        final auth =
            Provider.of<ForgetPasswordProvider>(context, listen: false);
        auth.clearData();
      });
    });
  }

  /* Dispose all the elements after closing the screen */
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgetPasswordProvider>(builder: (context, object, child) {
      return SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: size.width,
            child: Container(
              color: Colors.black,
              child: ListView(
                physics:const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: getVerticalSize(
                        24.00,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Forgot Password',
                        // overflow: TextOverflow.ellipsis,
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
                      //color: Colors.white,
                      child: Column(children: [
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      38.00,
                                    ),
                                    top: getVerticalSize(
                                      107.00,
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
                                      ImageConstant.imgGroup16,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: getHorizontalSize(
                                    351.00,
                                  ),
                                  margin: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      38.00,
                                    ),
                                    top: getVerticalSize(
                                      70.00,
                                    ),
                                    right: getHorizontalSize(
                                      38.00,
                                    ),
                                  ),
                                  child: Text(
                                    emailforgetText,
                                    maxLines: null,
                                    textAlign: TextAlign.center,
                                    style: AppStyle
                                        .textstylerobotoromanregular161
                                        .copyWith(
                                      fontSize: getFontSize(
                                        16,
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
                                        focusColor: ColorConstant.bluegray100,
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
                                          object.forgetPassword(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              38.00,
                                            ),
                                            top: getVerticalSize(
                                              40.00,
                                            ),
                                            right: getHorizontalSize(
                                              38.00,
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
                                                .textstylerobotoromansemibold16,
                                            child: Text(
                                              sendText.toUpperCase(),
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
                                          80.00,
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
                      ]),
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
