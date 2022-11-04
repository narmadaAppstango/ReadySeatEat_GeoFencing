import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plain_notification_token/plain_notification_token.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/cancelbookingdialog.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/common-imageView.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/reservation-view-popup.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/get-reservation-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/manual-searchScreen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/notification-screen.dart';
import '../Core/utils/color_constant.dart';
import '../Core/utils/image_constant.dart';
import '../Core/utils/widgets/custom-button.dart';
import '../Core/utils/widgets/custom-icon-button.dart';
import '../Core/utils/widgets/warning-dialogs.dart';
import '../Provider/api-service-provider.dart';
import '../Provider/logout-provider.dart';
import '../Provider/shared-preference.dart';
import '../core/utils/math_utils.dart';
import '../model/token-response-model.dart';
import '../theme/app_style.dart';
import 'QrCode-screen.dart';
import 'change-password-screen.dart';
import 'edit-profile-screen.dart';
import 'make-a-reservation.dart';

class PresentReservationScreen extends StatefulWidget {
  const PresentReservationScreen({Key? key}) : super(key: key);
  @override
  _PresentReservationScreenState createState() =>
      _PresentReservationScreenState();
}

class _PresentReservationScreenState extends State<PresentReservationScreen> {
  bool isvisible = false;
  String soc = '';
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  var devicetoken;
  var devicetype;
  TokenResponse? _tokenResponseDataModel;

  String _pushToken = 'Unknown';
  IosNotificationSettings? _settings;

  late StreamSubscription onTokenRefreshSubscription;
  late StreamSubscription onIosSubscription;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadInitial();
    });

    // onTokenRefreshSubscription =
    //     PlainNotificationToken().onTokenRefresh.listen((token) {
    //   setState(() {
    //     _pushToken = token;
    //     print('_pushToken ' + _pushToken);
    //   });
    // });
    // onIosSubscription =
    //     PlainNotificationToken().onIosSettingsRegistered.listen((settings) {
    //   setState(() {
    //     _settings = settings;
    //     print('_settings ' + _settings.toString());
    //   });
    // });
    // iostoken();
    tokenCall();
  }

  // @override
  // void dispose() {
  //   onTokenRefreshSubscription.cancel();
  //   onIosSubscription.cancel();
  //   super.dispose();
  // }

  // iostoken() async {
  //   PlainNotificationToken().requestPermission();
  //   late String? token;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     token = await PlainNotificationToken().getToken().then((value) {
  //       print('Plain IOS token >>>>>>> \n \n' + _pushToken);
  //       print('settings >>>>>>> \n \n' + _settings.toString());
  //       devicetoken=_pushToken;
  //     });
  //     token =await PlainNotificationToken().getToken();
  //     devicetoken=token;
  //   } on PlatformException {
  //     token = 'Failed to get platform version.';
  //   }
  // }

  tokenCall() {
    if (Platform.isIOS) {
      // PlainNotificationToken().requestPermission();
      late String? token;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        // FirebaseMessaging.instance.getAPNSToken().then((token) {
        //   // devicetoken = token;
        //   print("FIREBASE ASPN token dart >>>" + token.toString());
        //   // devicetype = Platform.isIOS ? 'ios': 'android';
        //   // sendToken();
        // });
        // token =await PlainNotificationToken().getToken();

        FirebaseMessaging.instance.getToken().then((fcmtoken) {
          print("FIREBASE FCM TOKEN IOS >>>" + fcmtoken.toString());
          token = fcmtoken;
          devicetoken=token;
          print("FIREBASE FCM TOKEN IOS >>>" + devicetoken.toString());
          sendToken();
        } );
      } on PlatformException {
        token = 'Failed to get platform version.';
      }
        devicetype = Platform.isIOS ? 'ios' : 'android';

    } else {
      FirebaseMessaging.instance.getToken().then((token) {
        devicetoken = token;
        print("FIREBASE FCM TOKEN >>> " + devicetoken.toString());
        devicetype = 'android';
        sendToken();
      });
    }
    // if (!mounted) return;
  }

  sendToken() async {
    String? token = 'Unknown';
    //  try {
    var uid = await SharedPreference().getUserId();
    print('USERID>>> ' + uid.toString().trim());
    if (devicetoken != null) {
      _tokenResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .sendDeviceTokenApi(uid.toString().trim(), devicetoken, Platform.isIOS?'ios':'android');
              // .then((value) async => _tokenResponseDataModel =
              //     await Provider.of<APIServiceProvider>(context, listen: false)
              //          .sendPushNotifiApi(uid.toString().trim()));
    } else {
      print('NOT SEND NOTIFICATION ');
    }
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
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        final auth =
            Provider.of<GetReservationProvider>(context, listen: false);
        auth.clearData();
      });
      if (soc == 'true') {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth =
              Provider.of<GetReservationProvider>(context, listen: false);
          auth.getreservationsdata(context);
        });
      } else {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth =
              Provider.of<GetReservationProvider>(context, listen: false);
          auth.getAccessToken(context);
        });
      }
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
    return Consumer<GetReservationProvider>(builder: (context, object, child) {
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
              appBar: AppBar(
                backgroundColor: ColorConstant.black900,
                title: const Text('Home'),
                automaticallyImplyLeading: false,
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationsScreen()));
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
                          WidgetsBinding.instance
                              ?.addPostFrameCallback((timeStamp) {
                            final auth = Provider.of<LogoutProvider>(context,
                                listen: false);
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
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 2.0),
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
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 2.0),
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
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 2.0),
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
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 2.0),
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
                        alignment: Alignment.topLeft,
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getHorizontalSize(
                                                  10.00,
                                                ),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      ColorConstant.black90040,
                                                  spreadRadius:
                                                      getHorizontalSize(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                      ImageConstant
                                                          .imgIonqrcodesha,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                30.00,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorConstant.amberA700,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getHorizontalSize(
                                                  10.00,
                                                ),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      ColorConstant.black90040,
                                                  spreadRadius:
                                                      getHorizontalSize(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                      ImageConstant
                                                          .imgAkariconssear,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                    Container(
                                      width: size.width * 0.87,
                                      height: size.height * 0.55,
                                      //color: ColorConstant.amberA700,
                                      margin: EdgeInsets.only(
                                          top: getVerticalSize(
                                            0.00,
                                          ),
                                          bottom: 20),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.amberA700,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            getHorizontalSize(
                                              15.00,
                                            ),
                                          ),
                                          topRight: Radius.circular(
                                            getHorizontalSize(
                                              15.00,
                                            ),
                                          ),
                                          bottomLeft: Radius.circular(
                                            getHorizontalSize(
                                              15.00,
                                            ),
                                          ),
                                          bottomRight: Radius.circular(
                                            getHorizontalSize(
                                              15.00,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Present reservation ',
                                              style: AppStyle
                                                  .textstylerobotoromansemibold16
                                                  .copyWith(fontSize: 15),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: object
                                                          .getreservations.length ==
                                                      0
                                                  ? Center(
                                                      child: Text(
                                                          'No reservations available'))
                                                  : ListView.builder(
                                                      itemCount: object
                                                          .getreservations
                                                          .length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          ClampingScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                            width: 300,
                                                            color: index % 2 !=
                                                                    0
                                                                ? ColorConstant
                                                                    .whiteA701
                                                                : ColorConstant
                                                                    .amberdisabled,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: size
                                                                              .width /
                                                                          3.5,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Text(
                                                                          'Booking id',
                                                                          style: AppStyle
                                                                              .textstylepoppinsregular13
                                                                              .copyWith(
                                                                            color:
                                                                                ColorConstant.amberA700,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Text(
                                                                        object
                                                                            .getreservations[index]
                                                                            .bookingId
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) => ReservationViewPopupScreen(
                                                                                                bookingid: object.getreservations[index].originalBookingId!,
                                                                                              )));
                                                                                });
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 7.0),
                                                                                child: CustomIconButton(
                                                                                  height: 24,
                                                                                  width: 24,
                                                                                  child: CommonImageView(
                                                                                    svgPath: 'assets/images/eye.svg',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MakeaReservationScreen('Edit Reservation', '', object.getreservations[index].originalBookingId!)));
                                                                                });
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 8.0, right: 5),
                                                                                child: CustomIconButton(
                                                                                  height: 24,
                                                                                  width: 24,
                                                                                  margin: getMargin(
                                                                                    left: 6,
                                                                                  ),
                                                                                  child: CommonImageView(
                                                                                    svgPath: 'assets/images/img_edit.svg',
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
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: size
                                                                              .width /
                                                                          3.5,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Text(
                                                                          'Restaurant name',
                                                                          style: AppStyle
                                                                              .textstylepoppinsregular13
                                                                              .copyWith(color: ColorConstant.amberA700),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Text(
                                                                        object
                                                                            .getreservations[index]
                                                                            .outletName
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: size.width /
                                                                            3.5,
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Text(
                                                                            'Queue no',
                                                                            style:
                                                                                AppStyle.textstylepoppinsregular13.copyWith(color: ColorConstant.amberA700),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10.0),
                                                                        child:
                                                                            Text(
                                                                          object
                                                                              .getreservations[index]
                                                                              .originalBookingId
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 3.0,
                                                                      bottom:
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: size.width /
                                                                            3.5,
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Text(
                                                                            'Current waiting time',
                                                                            style:
                                                                                AppStyle.textstylepoppinsregular13.copyWith(color: ColorConstant.amberA700),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10.0),
                                                                        child:
                                                                            Text(
                                                                          object
                                                                              .getreservations[index]
                                                                              .currentWaitTime
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 8.0, bottom: 10),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (BuildContext context) {
                                                                                        return CancelPopup(object.getreservations[index].originalBookingId.toString());
                                                                                      });
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                alignment: Alignment.center,
                                                                                height: getVerticalSize(
                                                                                  25.00,
                                                                                ),
                                                                                width: getHorizontalSize(
                                                                                  54.00,
                                                                                ),
                                                                                decoration: BoxDecoration(
                                                                                  color: ColorConstant.black900,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    getHorizontalSize(
                                                                                      10.00,
                                                                                    ),
                                                                                  ),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      color: ColorConstant.black90040,
                                                                                      offset: Offset(
                                                                                        0,
                                                                                        4,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                child: Text(
                                                                                  'Cancel',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: AppStyle.textstylerobotoromansemibold16.copyWith(
                                                                                    color: ColorConstant.amberA700,
                                                                                    fontSize: getFontSize(
                                                                                      13,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ));
                                                      }),
                                            ),
                                          ),
                                        ],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                                    title:
                                                                        'Profile',
                                                                    titlechange:
                                                                        false)));
                                                  },
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        top: getVerticalSize(
                                                          5.50,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Profile".toUpperCase(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
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
          ));
    });
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
