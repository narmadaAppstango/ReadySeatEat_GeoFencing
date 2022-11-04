import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/image_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/create-profile-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_decoration.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_style.dart';
import 'dart:math' as math;
import '../Core/constants/string-constants.dart';
import '../Core/utils/color_constant.dart';
import '../Core/utils/math_utils.dart';
import '../Core/utils/widgets/warning-dialogs.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  String soc = '';
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  /* Load datas into the screen initial stage */

  _loadInitial() async {
    var email = await SharedPreference().getemail();
    var soclogin = await SharedPreference().getSignedin();
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
      soc = soclogin.toString();
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        final auth = Provider.of<CreateProfileProvider>(context, listen: false);
        auth.setEmailID(email!);
      });
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        final auth = Provider.of<CreateProfileProvider>(context, listen: false);
        auth.clearData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateProfileProvider>(builder: (context, object, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.black900,
          body: SizedBox(
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.black900,
              ),
              child: ListView(
                physics:const ClampingScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          22.00,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(
                                100.00,
                              ),
                              right: getHorizontalSize(
                                100.00,
                              ),
                            ),
                            child: Text(
                              createProfileText,
                              //overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.textstylerobotoromanlight241
                                  .copyWith(
                                fontSize: getFontSize(
                                  20,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: size.width,
                              margin: EdgeInsets.only(
                                top: getVerticalSize(
                                  41.00,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: getVerticalSize(
                                          50.00,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                39.00,
                                              ),
                                              top: getVerticalSize(
                                                157.00,
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
                                                controller: object.firstName,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp("[a-zA-Z]")),
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: fname,
                                                  hintStyle: AppStyle
                                                      .textstylerobotoromanregular16
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      16.0,
                                                    ),
                                                    color:
                                                        ColorConstant.gray900,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        16.00,
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
                                                        ImageConstant.imgUser,
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
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      19.48,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      19.48,
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
                                                30.00,
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
                                                controller: object.middleName,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp("[a-zA-Z]")),
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: mname,
                                                  hintStyle: AppStyle
                                                      .textstylerobotoromanregular16
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      16.0,
                                                    ),
                                                    color:
                                                        ColorConstant.gray900,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        16.00,
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
                                                        ImageConstant.imgUser1,
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
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      19.48,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      19.48,
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
                                                30.00,
                                              ),
                                              right: getHorizontalSize(
                                                39.00,
                                              ),
                                            ),
                                            child: Container(
                                              height: getVerticalSize(
                                                60.00,
                                              ),
                                              width: getHorizontalSize(
                                                350.00,
                                              ),
                                              child: TextFormField(
                                                controller: object.lastName,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp("[a-zA-Z]")),
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: lname,
                                                  hintStyle: AppStyle
                                                      .textstylerobotoromanregular16
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      16.0,
                                                    ),
                                                    color:
                                                        ColorConstant.gray900,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        16.00,
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
                                                        ImageConstant.imgUser2,
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
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      19.48,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      19.48,
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
                                                30.00,
                                              ),
                                              right: getHorizontalSize(
                                                39.00,
                                              ),
                                            ),
                                            child: Container(
                                              height: getVerticalSize(
                                                60.00,
                                              ),
                                              width: getHorizontalSize(
                                                350.00,
                                              ),
                                              child: TextFormField(
                                                controller: object.phoneNo,
                                                keyboardType:
                                                    const TextInputType
                                                            .numberWithOptions(
                                                        signed: false,
                                                        decimal: false),
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: phNo,
                                                  hintStyle: AppStyle
                                                      .textstylerobotoromanregular16
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      16.0,
                                                    ),
                                                    color:
                                                        ColorConstant.gray900,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        16.00,
                                                      ),
                                                      right: getHorizontalSize(
                                                        10.00,
                                                      ),
                                                    ),
                                                    child: Container(
                                                      height: getSize(
                                                        24.00,
                                                      ),
                                                      width: getSize(
                                                        24.00,
                                                      ),
                                                      child: SvgPicture.asset(
                                                        ImageConstant.imgPhone,
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
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      21.48,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      17.48,
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
                                                30.00,
                                              ),
                                              right: getHorizontalSize(
                                                39.00,
                                              ),
                                            ),
                                            child: Container(
                                              height: getVerticalSize(
                                                60.00,
                                              ),
                                              width: getHorizontalSize(
                                                350.00,
                                              ),
                                              child: TextFormField(
                                                controller: object.email,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: email,
                                                  hintStyle: AppStyle
                                                      .textstylerobotoromanregular16
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      16.0,
                                                    ),
                                                    color:
                                                        ColorConstant.gray900,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        50.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          ColorConstant.gray401,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        16.00,
                                                      ),
                                                      right: getHorizontalSize(
                                                        10.00,
                                                      ),
                                                    ),
                                                    child: Container(
                                                      height: getSize(
                                                        24.00,
                                                      ),
                                                      width: getSize(
                                                        24.00,
                                                      ),
                                                      child: SvgPicture.asset(
                                                        ImageConstant.imgMail2,
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
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      21.48,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      17.48,
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
                                                      if (object.isclicked ==
                                                          true) {
                                                        object.isclicked =
                                                            false;
                                                        if (soc == 'true') {
                                                          object
                                                              .createUserProfile(
                                                                  context,
                                                                  '0',
                                                                  soc);
                                                        } else {
                                                          object
                                                              .createUserProfile(
                                                                  context,
                                                                  '0',
                                                                  'normal');
                                                        }
                                                      }
                                                    });
                                                  },
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          39.00,
                                                        ),
                                                        top: getVerticalSize(
                                                          34.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
                                                          39.00,
                                                        ),
                                                        bottom: getVerticalSize(
                                                          60.00,
                                                        ),
                                                      ),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: getVerticalSize(
                                                          60.00,
                                                        ),
                                                        width:
                                                            getHorizontalSize(
                                                          350.00,
                                                        ),
                                                        decoration: AppDecoration
                                                            .textstylerobotoromansemibold16,
                                                        child: Text(
                                                          save.toUpperCase(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .textstylerobotoromansemibold16
                                                              .copyWith(
                                                            fontSize:
                                                                getFontSize(
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
                                  GestureDetector(
                                    onTap: () {
                                      object.openPicChooserWindow(context);
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: getSize(
                                          128.00,
                                        ),
                                        width: getSize(
                                          128.00,
                                        ),
                                        margin: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            143.00,
                                          ),
                                          right: getHorizontalSize(
                                            143.00,
                                          ),
                                          bottom: getVerticalSize(
                                            10.00,
                                          ),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                height: getSize(
                                                  128.00,
                                                ),
                                                width: getSize(
                                                  128.00,
                                                ),
                                                child: Transform.rotate(
                                                  angle: 90 / 180 * math.pi,
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: object
                                                            .imagePickedFile
                                                            .isAbsolute
                                                        ? 1
                                                        : 0.5,
                                                    backgroundColor:
                                                        ColorConstant.whiteA700,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      ColorConstant.amberA700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: getSize(
                                                  120.00,
                                                ),
                                                width: getSize(
                                                  120.00,
                                                ),
                                                margin: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    4.00,
                                                  ),
                                                  top: getVerticalSize(
                                                    4.00,
                                                  ),
                                                  right: getHorizontalSize(
                                                    4.00,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    4.00,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: ColorConstant.gray100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    getHorizontalSize(
                                                      60.00,
                                                    ),
                                                  ),
                                                ),
                                                child: Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  elevation: 0,
                                                  margin:
                                                      const EdgeInsets.all(2.0),
                                                  color: ColorConstant.gray100,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        60.00,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: SizedBox(
                                                          height: getSize(
                                                            120.00,
                                                          ),
                                                          width: getSize(
                                                            120.00,
                                                          ),
                                                          child: object
                                                                  .imagePickedFile
                                                                  .isAbsolute
                                                              ? SizedBox(
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          48, // Image radius
                                                                      backgroundImage: FileImage(
                                                                          object
                                                                              .imagePickedFile,
                                                                          scale:
                                                                              2.0),
                                                                    ),
                                                                  ),
                                                                )
                                                              : SvgPicture
                                                                  .asset(
                                                                  ImageConstant
                                                                      .imgMaskgroup,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
