import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/QrCode-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/change-password-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/manual-searchScreen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/notification-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import '../Core/utils/color_constant.dart';
import '../Core/utils/image_constant.dart';
import '../Core/utils/math_utils.dart';
import '../Core/utils/widgets/common-imageView.dart';
import '../Core/utils/widgets/custom-button.dart';
import '../Provider/logout-provider.dart';
import '../theme/app_style.dart';
import 'edit-profile-screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isvisible = false;
  String soc = '';
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadInitial();
    });
  }

  _loadInitial() async {
    var soclogin = await SharedPreference().getSignedin();
    setState(() {
      // _connectivitySubscription = Connectivity()
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
    });
  }

  showAlertDialogAdd(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 40, top: 100, right: 40, bottom: 100),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 10),
                          blurRadius: 10),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Are you sure?',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 24,
                        top: 51,
                        right: 22,
                        bottom: 31,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CustomButton(
                            width: 140,
                            text: "No".toUpperCase(),
                            variant: ButtonVariant.OutlineBlack9003f1_2,
                            fontStyle:
                                ButtonFontStyle.RobotoRomanSemiBold16WhiteA700,
                          ),
                          CustomButton(
                            width: 140,
                            text: "yes".toUpperCase(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 10,
                  child: CommonImageView(
                    svgPath: ImageConstant.imgGroup42,
                    height: getSize(
                      120.00,
                    ),
                    width: getSize(
                      120.00,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.black900,
        appBar: AppBar(
          backgroundColor: ColorConstant.black900,
          title: const Text('Find a Restaurant'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsScreen()));
              },
              child: Padding(
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
                          builder: (context) => const EditProfileScreen(
                                title: 'Edit Profile',
                                titlechange: true,
                              )));
                } else if (value == 1) {
                  if (soc.toString() == 'true') {
                    warningDialogs(context,
                        'This option is not available for social login');
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ChangePasswordScreen()));
                  }
                } else if (value == 2) {
                  warningDialogs(context, 'This option is coming soon');
                  //warningDialogs(context, 'This option is coming soon');
                } else if (value == 3) {
                  warningDialogs(context, 'This option is coming soon');
                } else if (value == 4) {
                  warningDialogs(context, 'This option is coming soon');
                } else if (value == 5) {
                  setState(() {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      final auth =
                          Provider.of<LogoutProvider>(context, listen: false);
                      auth.logoutDialogs(context, 'Are you sure?');
                    });
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
                              padding: const EdgeInsets.only(left: 8.0),
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
                          padding: const EdgeInsets.only(top: 8.0, right: 8.0),
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
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset(
                                ImageConstant.imgLock5,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 2.0),
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
                    value: 2,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset(
                                ImageConstant.contactus,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 2.0),
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
                    value: 3,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset(
                                ImageConstant.privacypolicy,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 2.0),
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
                    value: 4,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset(
                                ImageConstant.termsandc,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 2.0),
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
                    value: 5,
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
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getVerticalSize(
                        0.00,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: getVerticalSize(
                              0.00,
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
                                  35.00,
                                ),
                              ),
                              bottomRight: Radius.circular(
                                getHorizontalSize(
                                  35.00,
                                ),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const QrCodeScreen()));
                                  });
                                  // warningDialogs(context,
                                  //     'This option is under development');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: getVerticalSize(
                                      39.00,
                                    ),
                                    bottom: getVerticalSize(
                                      10.00,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.amberA700,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        10.00,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorConstant.black90040,
                                        spreadRadius: getHorizontalSize(
                                          2.00,
                                        ),
                                        blurRadius: getHorizontalSize(
                                          2.00,
                                        ),
                                        offset: const Offset(
                                          0,
                                          4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            36.00,
                                          ),
                                          top: getVerticalSize(
                                            22.00,
                                          ),
                                          right: getHorizontalSize(
                                            36.00,
                                          ),
                                        ),
                                        child: Container(
                                          height: getSize(
                                            88.00,
                                          ),
                                          width: getSize(
                                            88.00,
                                          ),
                                          child: SvgPicture.asset(
                                            ImageConstant.imgIonqrcodesha,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            36.00,
                                          ),
                                          top: getVerticalSize(
                                            11.00,
                                          ),
                                          right: getHorizontalSize(
                                            36.00,
                                          ),
                                          bottom: getVerticalSize(
                                            20.00,
                                          ),
                                        ),
                                        child: Text(
                                          "Scan".toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .textstylerobotoromansemibold20
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
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                    pushWithoutAnimation(
                                        const PresentReservationScreen(),
                                        context);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: getVerticalSize(
                                      39.00,
                                    ),
                                    bottom: getVerticalSize(
                                      529.00,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.amberA700,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        10.00,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorConstant.black90040,
                                        spreadRadius: getHorizontalSize(
                                          2.00,
                                        ),
                                        blurRadius: getHorizontalSize(
                                          2.00,
                                        ),
                                        offset: const Offset(
                                          0,
                                          4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            36.00,
                                          ),
                                          top: getVerticalSize(
                                            25.00,
                                          ),
                                          right: getHorizontalSize(
                                            36.00,
                                          ),
                                        ),
                                        child: Container(
                                          height: getSize(
                                            88.00,
                                          ),
                                          width: getSize(
                                            88.00,
                                          ),
                                          child: SvgPicture.asset(
                                            ImageConstant.imgAkariconssear,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            36.00,
                                          ),
                                          top: getVerticalSize(
                                            8.00,
                                          ),
                                          right: getHorizontalSize(
                                            36.00,
                                          ),
                                          bottom: getVerticalSize(
                                            20.00,
                                          ),
                                        ),
                                        child: Text(
                                          "Manual".toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .textstylerobotoromansemibold20
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
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PresentReservationScreen()));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    57.00,
                                  ),
                                  top: getVerticalSize(
                                    14.00,
                                  ),
                                  bottom: getVerticalSize(
                                    14.00,
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
                                          11.00,
                                        ),
                                        right: getHorizontalSize(
                                          11.00,
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
                                          ImageConstant.imgHome,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: getVerticalSize(
                                            10.00,
                                          ),
                                        ),
                                        child: Text(
                                          "Home".toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .textstylerobotoromansemibold164
                                              .copyWith(
                                            fontSize: getFontSize(
                                              16,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfileScreen(
                                                title: 'Profile',
                                                titlechange: false)));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    81.00,
                                  ),
                                  right: getHorizontalSize(
                                    60.00,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: getVerticalSize(
                                        81.00,
                                      ),
                                      width: getHorizontalSize(
                                        1.00,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.gray800,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          73.00,
                                        ),
                                        top: getVerticalSize(
                                          18.50,
                                        ),
                                        bottom: getVerticalSize(
                                          14.00,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                20.00,
                                              ),
                                              right: getHorizontalSize(
                                                13.00,
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
                                                ImageConstant.imgUser3,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EditProfileScreen(
                                                              title: 'Profile',
                                                              titlechange:
                                                                  false)));
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: getVerticalSize(
                                                    5.50,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Profile".toUpperCase(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .textstylerobotoromansemibold165
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
  }

  Future pushWithoutAnimation<T extends Object>(
      Widget page, BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page),
        (Route<dynamic> route) => false);
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManualSearchScreen()),
    );
  }
}
