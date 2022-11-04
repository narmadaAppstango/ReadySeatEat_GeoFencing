import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';

import '../Core/utils/color_constant.dart';
import '../Core/utils/image_constant.dart';
import '../Core/utils/math_utils.dart';
import '../Core/utils/widgets/common-imageView.dart';
import '../Core/utils/widgets/warning-dialogs.dart';
import '../Provider/get-restaurent-detailsProvider.dart';
import '../Provider/logout-provider.dart';
import '../Provider/shared-preference.dart';
import '../theme/app_decoration.dart';
import '../theme/app_style.dart';
import 'edit-profile-screen.dart';
import 'forget-password-screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String soc = '';
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<String> notificationsList = ['Notif', 'notific'];
  bool check = true;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  _loadInitial() async {
    var soclogin = await SharedPreference().getSignedin();
    setState(() {
      // _connectivitySubscription = Connectivity()
      //   .onConnectivityChanged
      //   .listen((ConnectivityResult result) {
      // if (result == ConnectivityResult.none) {
      //   warningDialogs(context, 'You are currently offline.');
      // } else {
      //   warningDialogs(context, 'Your internet connection has been rstored.');
      // }
      // // Got a new connectivity status!
      // });
      soc = soclogin.toString();
      if (soc == 'true') {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth =
              Provider.of<GetRestaurentDetailsProvider>(context, listen: false);
          auth.getRestaurents(context);
        });
      } else {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth =
              Provider.of<GetRestaurentDetailsProvider>(context, listen: false);
          auth.getAccessToken(context, '', 'ResSear');
        });
      }
    });
  }

  ScrollController scrollcontroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRestaurentDetailsProvider>(
        builder: (context, object, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.black900,
          appBar: AppBar(
            backgroundColor: ColorConstant.black900,
            title: const Text('Notification'),
            automaticallyImplyLeading: false,
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
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationsScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 18, left: 10),
                  child: SizedBox(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordSentScreen()));
                  } else if (value == 2) {
                    warningDialogs(context, 'This option is coming soon');
                  } else if (value == 3) {
                    warningDialogs(context, 'This option is coming Soon');
                  } else if (value == 4) {
                    warningDialogs(context, 'This option is coming soon');
                  } else if (value == 5) {
                    warningDialogs(context, 'This option is coming soon');
                  } else if (value == 6) {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      final auth =
                          Provider.of<LogoutProvider>(context, listen: false);
                      auth.logoutDialogs(context, 'Are You Sure?');
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
                            padding:
                                const EdgeInsets.only(top: 8.0, right: 8.0),
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
                                  ImageConstant.resetpassword,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 2.0),
                                child: Text('Reset Password'),
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
                      value: 4,
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
                      value: 5,
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
          body: Container(
            margin: EdgeInsets.only(
              top: getVerticalSize(
                20.00,
              ),
            ),
            decoration: BoxDecoration(
              color: ColorConstant.whiteA701,
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
            child: ListView(physics:const ClampingScrollPhysics(), children: [
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: notificationsList.isEmpty
                      ? const Center(
                          child: Text('No notifications available'))
                      : ListView.builder(
                          itemCount: notificationsList.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () async {},
                                child: Container(
                                    width: size.width * 1.3,
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 10, right: 20),
                                    decoration: AppDecoration
                                        .outlineBluegray100
                                        .copyWith(
                                            borderRadius:
                                                BorderRadiusStyle
                                                    .circleBorder45),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets
                                                            .only(
                                                        left: 25,
                                                        top: 5,
                                                        bottom: 5,
                                                        right: 5),
                                                child: SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                      'You are about to check in',
                                                      overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                      textAlign:
                                                          TextAlign
                                                              .left,
                                                      maxLines: 4,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets
                                                        .only(
                                                  left: 20,
                                                  top: 5,
                                                  bottom: 5,
                                                  right: 5,
                                                ),
                                                child: SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                      'Customer is within 50 feet radius of the restaurant address',
                                                      overflow:
                                                          TextOverflow
                                                              .clip,
                                                      textAlign:
                                                          TextAlign
                                                              .left,
                                                      maxLines: 2,
                                                      softWrap: true,
                                                      style: AppStyle
                                                          .txtRobotoRomanRegular16
                                                          .copyWith()),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                              padding: getPadding(
                                                  top: 14,
                                                  right: 22,
                                                  bottom: 14),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:
                                                          () async {},
                                                      child: Theme(
                                                        data: ThemeData(
                                                            unselectedWidgetColor:
                                                                ColorConstant
                                                                    .amberA700),
                                                        child: Transform
                                                            .scale(
                                                          scale: 1.2,
                                                          child: Checkbox(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(4.0),
                                                              ),
                                                              value: check,
                                                              materialTapTargetSize: MaterialTapTargetSize.padded,
                                                              checkColor: ColorConstant.black900,
                                                              activeColor: ColorConstant.amberA700,
                                                              hoverColor: ColorConstant.amberA700,
                                                              onChanged: (value) {
                                                                setState(
                                                                    () {
                                                                  check =
                                                                      value!;
                                                                  // print('check' +
                                                                  //     object
                                                                  //         .isChecked
                                                                  //         .toString());
                                                                  // if (object
                                                                  //         .isChecked ==
                                                                  //     true) {
                                                                  //   object.tokenCall(
                                                                  //       context);
                                                                  // } else {}
                                                                });
                                                              }),
                                                        ),
                                                      ),
                                                    )
                                                  ]))
                                        ])),
                              ),
                            );
                          }))
            ]),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                        child: Container(
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
                            style: AppStyle.textstylerobotoromansemibold164
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
                          builder: (context) => const EditProfileScreen(
                              title: 'Profile', titlechange: false)));
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: getVerticalSize(
                                    5.50,
                                  ),
                                ),
                                child: Text(
                                  "Profile".toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
