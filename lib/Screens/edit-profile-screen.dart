import 'dart:async';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/image_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/create-profile-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/logout-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-in-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/forget-password-screen.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_decoration.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_style.dart';
import 'dart:math' as math;
import '../Core/constants/string-constants.dart';
import '../Core/utils/color_constant.dart';
import '../Core/utils/custom-dialogs.dart';
import '../Core/utils/math_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(
      {Key? key, required this.title, required this.titlechange})
      : super(key: key);
  final String title;
  final bool titlechange;
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String soc = '';
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  /* Load datas into the screen initial stage */

  _loadInitial() async {
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
      if (widget.titlechange == true) {
        if (soc == 'true') {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            final auth =
                Provider.of<CreateProfileProvider>(context, listen: false);
            auth.getProfileDetails(context, 'EditProfile', soc);
          });
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            final auth =
                Provider.of<CreateProfileProvider>(context, listen: false);
            auth.getProfileDetails(context, 'EditProfile', '');
          });
        }
      } else {
        if (soc == 'true') {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            final auth =
                Provider.of<CreateProfileProvider>(context, listen: false);
            auth.getProfileDetails(context, 'Profile', soc);
          });
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            final auth =
                Provider.of<CreateProfileProvider>(context, listen: false);
            auth.getProfileDetails(context, 'Profile', '');
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateProfileProvider>(builder: (context, object, child) {
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
            appBar: widget.titlechange == true
                ? AppBar(
                    backgroundColor: ColorConstant.black900,
                    title: Text(widget.title),
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: ColorConstant.amberA700,
                      ),
                    ),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                  )
                : AppBar(
                    backgroundColor: ColorConstant.black900,
                    title: Text('Profile'),
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: ColorConstant.amberA700,
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(top: 18, bottom: 18, left: 10),
                        child: Container(
                          height: getSize(
                            24.00,
                          ),
                          width: getSize(
                            24.00,
                          ),
                          child: SvgPicture.asset(
                            ImageConstant.imgBell,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      PopupMenuButton(
                        offset: const Offset(5, 55),
                        icon: SvgPicture.asset(
                          ImageConstant.imgGroup18,
                          fit: BoxFit.fill,
                          height: getVerticalSize(
                            20.00,
                          ),
                          width: getHorizontalSize(
                            6.00,
                          ),
                        ),
                        onSelected: (value) {
                          if (value == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen(
                                          title: 'Edit Profile',
                                          titlechange: true,
                                        )));
                          } else if (value == 1) {
                            warningDialogs(
                                context, 'This option is coming soon');
                          } else if (value == 2) {
                            warningDialogs(
                                context, 'This option is coming soon');
                          } else if (value == 3) {
                            warningDialogs(
                                context, 'This option is coming soon');
                          } else if (value == 4) {
                            warningDialogs(
                                context, 'This option is coming soon');
                          } else if (value == 5) {
                            warningDialogs(
                                context, 'This option is coming soon');
                          } else if (value == 6) {
                            WidgetsBinding.instance
                                ?.addPostFrameCallback((timeStamp) {
                              final auth = Provider.of<LogoutProvider>(context,
                                  listen: false);
                              auth.logoutDialogs(context, 'Are you sure?');
                            });
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 0,
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgUseredit,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text('Edit Profile'),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, right: 8.0),
                                    child: Container(
                                      color: ColorConstant.black90040,
                                      width: size.width * 0.37,
                                      height: 1,
                                    ),
                                  )
                                ],
                              )),
                          PopupMenuItem(
                              value: 1,
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgLock5,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 2.0),
                                        child: Text('Change Password'),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                    ),
                                    child: Container(
                                      color: ColorConstant.black90040,
                                      width: size.width * 0.37,
                                      height: 1,
                                    ),
                                  )
                                ],
                              )),
                          PopupMenuItem(
                              value: 3,
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: SvgPicture.asset(
                                          ImageConstant.contactus,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 2.0),
                                        child: Text('Contact us'),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                    ),
                                    child: Container(
                                      color: ColorConstant.black90040,
                                      width: size.width * 0.37,
                                      height: 1,
                                    ),
                                  )
                                ],
                              )),
                          PopupMenuItem(
                              value: 4,
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: SvgPicture.asset(
                                          ImageConstant.privacypolicy,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 2.0),
                                        child: Text('Privacy Policy'),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                    ),
                                    child: Container(
                                      color: ColorConstant.black90040,
                                      width: size.width * 0.37,
                                      height: 1,
                                    ),
                                  )
                                ],
                              )),
                          PopupMenuItem(
                              value: 5,
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: SvgPicture.asset(
                                          ImageConstant.termsandc,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 2.0),
                                        child: Text('Terms & Conditions'),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                    ),
                                    child: Container(
                                      color: ColorConstant.black90040,
                                      width: size.width * 0.37,
                                      height: 1,
                                    ),
                                  )
                                ],
                              )),
                          PopupMenuItem(
                              value: 6,
                              padding: EdgeInsets.zero,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 9.0),
                                    child: SvgPicture.asset(
                                      ImageConstant.imgGroup,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Log out'),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
            body: SizedBox(
              width: size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstant.black900,
                ),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            10.00,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: size.width,
                                margin: EdgeInsets.only(
                                  top: getVerticalSize(
                                    10.00,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: widget.titlechange == 'true'
                                            ? size.height
                                            : size.height / 1.21,
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
                                                  130.00,
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
                                                  autofocus: false,
                                                  controller: object.firstName,
                                                  readOnly:
                                                      widget.titlechange == true
                                                          ? false
                                                          : true,
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
                                                        color: ColorConstant
                                                            .gray401,
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
                                                        color: ColorConstant
                                                            .gray401,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    prefixIcon: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          16.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
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
                                                    color:
                                                        ColorConstant.gray900,
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
                                                  autofocus: false,
                                                  controller: object.middleName,
                                                  readOnly:
                                                      widget.titlechange == true
                                                          ? false
                                                          : true,
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
                                                        color: ColorConstant
                                                            .gray401,
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
                                                        color: ColorConstant
                                                            .gray401,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    prefixIcon: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          16.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
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
                                                          ImageConstant
                                                              .imgUser1,
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
                                                    color:
                                                        ColorConstant.gray900,
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
                                                  autofocus: false,
                                                  controller: object.lastName,
                                                  readOnly:
                                                      widget.titlechange == true
                                                          ? false
                                                          : true,
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
                                                        color: ColorConstant
                                                            .gray401,
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
                                                        color: ColorConstant
                                                            .gray401,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    prefixIcon: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          16.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
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
                                                          ImageConstant
                                                              .imgUser2,
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
                                                    color:
                                                        ColorConstant.gray900,
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
                                                  autofocus: false,
                                                  controller: object.phoneNo,
                                                  readOnly:
                                                      widget.titlechange == true
                                                          ? false
                                                          : true,
                                                  keyboardType: TextInputType
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
                                                        color: ColorConstant
                                                            .gray401,
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
                                                        color: ColorConstant
                                                            .gray401,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    prefixIcon: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          16.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
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
                                                          ImageConstant
                                                              .imgPhone,
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
                                                    color:
                                                        ColorConstant.gray900,
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
                                                  autofocus: false,
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
                                                        color: ColorConstant
                                                            .gray401,
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
                                                        color: ColorConstant
                                                            .gray401,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    prefixIcon: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          16.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
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
                                                          ImageConstant
                                                              .imgMail2,
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
                                                    color:
                                                        ColorConstant.gray900,
                                                    fontSize: getFontSize(
                                                      16.0,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            object.status ==
                                                    Status.authenticating
                                                ? Center(
                                                    child: SizedBox(
                                                      child: Lottie.asset(
                                                          "assets/loading-rs.json"),
                                                      width: 100,
                                                      height: 100,
                                                    ),
                                                  )
                                                : Align(
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
                                                          10.00,
                                                        ),
                                                      ),
                                                      child: Visibility(
                                                        visible:
                                                            widget.titlechange,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (object
                                                                      .isclicked ==
                                                                  true) {
                                                                print('Click' +
                                                                    object
                                                                        .isclicked
                                                                        .toString());
                                                                object.isclicked =
                                                                    false;
                                                                if (soc.toString() ==
                                                                    'true') {
                                                                  object.createUserProfile(
                                                                      context,
                                                                      '1',
                                                                      soc);
                                                                } else {
                                                                  object.createUserProfile(
                                                                      context,
                                                                      '1',
                                                                      'normal');
                                                                }
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height:
                                                                getVerticalSize(
                                                              60.00,
                                                            ),
                                                            width:
                                                                getHorizontalSize(
                                                              350.00,
                                                            ),
                                                            decoration:
                                                                AppDecoration
                                                                    .textstylerobotoromansemibold16,
                                                            child: Text(
                                                              done.toUpperCase(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                                  ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    39.00,
                                                  ),
                                                  top: getVerticalSize(
                                                    10.00,
                                                  ),
                                                  right: getHorizontalSize(
                                                    39.00,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    20.00,
                                                  ),
                                                ),
                                                child: Visibility(
                                                  visible: widget.titlechange,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        Navigator.of(context).push(
                                                            PageRouteBuilder(
                                                                opaque: false,
                                                                pageBuilder: (BuildContext
                                                                            context,
                                                                        _,
                                                                        __) =>
                                                                    FullScreenDialog()));
                                                      });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: getVerticalSize(
                                                        60.00,
                                                      ),
                                                      width: getHorizontalSize(
                                                        350.00,
                                                      ),
                                                      decoration: AppDecoration
                                                          .textstylerobotoromansemibold166,
                                                      child: Text(
                                                        'Delete Account'
                                                            .toUpperCase(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .textstylerobotoromansemibold16
                                                            .copyWith(
                                                          color: ColorConstant
                                                              .amberA700,
                                                          fontSize: getFontSize(
                                                            16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    object.profileImage == 'true'
                                        ? Align(
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: SizedBox(
                                                      height: getSize(
                                                        128.00,
                                                      ),
                                                      width: getSize(
                                                        128.00,
                                                      ),
                                                      child: Transform.rotate(
                                                        angle:
                                                            90 / 180 * math.pi,
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: 0.5,
                                                          backgroundColor:
                                                              ColorConstant
                                                                  .whiteA700,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            ColorConstant
                                                                .amberA700,
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
                                                        right:
                                                            getHorizontalSize(
                                                          4.00,
                                                        ),
                                                        bottom: getVerticalSize(
                                                          4.00,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .gray100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          getHorizontalSize(
                                                            60.00,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Card(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        elevation: 0,
                                                        margin: const EdgeInsets
                                                            .all(2.0),
                                                        color: ColorConstant
                                                            .gray100,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                                                  height:
                                                                      getSize(
                                                                    120.00,
                                                                  ),
                                                                  width:
                                                                      getSize(
                                                                    120.00,
                                                                  ),
                                                                  child: object
                                                                          .image
                                                                          .isEmpty
                                                                      ? SvgPicture
                                                                          .asset(
                                                                          ImageConstant
                                                                              .imgMaskgroup,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )
                                                                      : SizedBox(
                                                                          child:
                                                                              FittedBox(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            child:
                                                                                CircleAvatar(
                                                                              radius: 10, // Image radius
                                                                              backgroundImage: NetworkImage(object.image, scale: 2.0),
                                                                            ),
                                                                          ),
                                                                        )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              object.openPicChooserWindow(
                                                  context);
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: SizedBox(
                                                        height: getSize(
                                                          128.00,
                                                        ),
                                                        width: getSize(
                                                          128.00,
                                                        ),
                                                        child: Transform.rotate(
                                                          angle: 90 /
                                                              180 *
                                                              math.pi,
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: 0.5,
                                                            backgroundColor:
                                                                ColorConstant
                                                                    .whiteA700,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              ColorConstant
                                                                  .amberA700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        height: getSize(
                                                          120.00,
                                                        ),
                                                        width: getSize(
                                                          120.00,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                            4.00,
                                                          ),
                                                          top: getVerticalSize(
                                                            4.00,
                                                          ),
                                                          right:
                                                              getHorizontalSize(
                                                            4.00,
                                                          ),
                                                          bottom:
                                                              getVerticalSize(
                                                            4.00,
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorConstant
                                                              .gray100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            getHorizontalSize(
                                                              60.00,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Card(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          elevation: 0,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          color: ColorConstant
                                                              .gray100,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                    height:
                                                                        getSize(
                                                                      120.00,
                                                                    ),
                                                                    width:
                                                                        getSize(
                                                                      120.00,
                                                                    ),
                                                                    child: object.image.isEmpty ||
                                                                            object.imagePickedFile.isAbsolute
                                                                        ? object.imagePickedFile.isAbsolute
                                                                            ? SizedBox(
                                                                                child: FittedBox(
                                                                                  fit: BoxFit.fill,
                                                                                  child: CircleAvatar(
                                                                                    radius: 48, // Image radius
                                                                                    backgroundImage: FileImage(object.imagePickedFile, scale: 2.0),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : SvgPicture.asset(
                                                                                ImageConstant.imgMaskgroup,
                                                                                fit: BoxFit.fill,
                                                                              )
                                                                        : SizedBox(
                                                                            child:
                                                                                FittedBox(
                                                                              fit: BoxFit.fill,
                                                                              child: CircleAvatar(
                                                                                radius: 48, // Image radius
                                                                                backgroundImage: NetworkImage(object.image, scale: 2.0),
                                                                              ),
                                                                            ),
                                                                          )),
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
        ),
      );
    });
  }
}
