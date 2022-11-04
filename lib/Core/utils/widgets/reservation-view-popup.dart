import 'dart:async';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/app_export.dart';

import 'package:flutter/material.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/cancelbookingdialog.dart';

import '../../../Provider/get-reservation-provider.dart';
import '../../../Provider/make-reservation-provider.dart';
import '../../../Provider/shared-preference.dart';
import '../../../Screens/present-reservation-screen.dart';
import 'common-imageView.dart';
import 'custom-button.dart';

class ReservationViewPopupScreen extends StatefulWidget {
  ReservationViewPopupScreen({this.bookingid, Key? key}) : super(key: key);
  String? bookingid;
  @override
  _ReservationViewPopupScreenState createState() =>
      _ReservationViewPopupScreenState();
}

class _ReservationViewPopupScreenState
    extends State<ReservationViewPopupScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String soc = '';
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
      // });
      soc = soclogin.toString();
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        final auth =
            Provider.of<MakeReservationProvider>(context, listen: false);
        auth.clearData();
      });

      if (soc == 'true') {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth =
              Provider.of<MakeReservationProvider>(context, listen: false);
          auth.getpreviousreservationsdata(context, widget.bookingid!);
        });
      } else {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth =
              Provider.of<MakeReservationProvider>(context, listen: false);
          auth.getAccessToken(context, '', widget.bookingid!, '', '');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MakeReservationProvider>(builder: (context, object, child) {
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
                body:
                    ListView(physics: const ClampingScrollPhysics(), children: [
                  Stack(alignment: Alignment.topCenter, children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            decoration: AppDecoration.groupstyleblack900,
                            child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                          margin: getMargin(
                                              left: 25,
                                              top: 50,
                                              right: 25,
                                              bottom: 40),
                                          decoration: AppDecoration
                                              .fillWhiteA700
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder40),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorConstant.amberd,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30),
                                                      topRight:
                                                          Radius.circular(30),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Padding(
                                                                padding:
                                                                    getPadding(
                                                                        left:
                                                                            15,
                                                                        top: 19,
                                                                        right:
                                                                            15),
                                                                child: CommonImageView(
                                                                    svgPath:
                                                                        ImageConstant
                                                                            .imgClose,
                                                                    height:
                                                                        getSize(
                                                                            26.00),
                                                                    width: getSize(
                                                                        26.00)))),
                                                      ),
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Text(object.username!),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: ColorConstant
                                                                      .amberlight,
                                                                  width:
                                                                      getHorizontalSize(
                                                                    1.00,
                                                                  ),
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius
                                                                            .zero)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.width /
                                                                      2.1,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .mail),
                                                                  Text(
                                                                    object
                                                                        .useremail!,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        overflow:
                                                                            TextOverflow.ellipsis),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          8.0),
                                                              child: Container(
                                                                color: ColorConstant
                                                                    .amberlight,
                                                                height: 60,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  const Icon(Icons
                                                                      .phone_android),
                                                                  Text(
                                                                    object
                                                                        .userPhoneNo!,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 38,
                                                            right: 15),
                                                        child: Text(
                                                            "Reservation Id",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRomanBold14AmberA700
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 12,
                                                            right: 15),
                                                        child: Text(
                                                            object.bookingID!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRegular20
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 15,
                                                            right: 15),
                                                        child: Text(
                                                            "Queue Number",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRomanBold14AmberA700
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 4,
                                                            right: 15),
                                                        child: Text("5019",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRegular20
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 15,
                                                            right: 15),
                                                        child: Text(
                                                            "Party Size",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRomanBold14AmberA700
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 6,
                                                            right: 15),
                                                        child: Text(
                                                            object.partySize
                                                                    .toString() +
                                                                ' People',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRegular20
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 15,
                                                            right: 15),
                                                        child: Text(
                                                            "Restaurant name",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRomanBold14AmberA700
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 7,
                                                            right: 15),
                                                        child: Text(
                                                            object
                                                                .restaurantname!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRegular20
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 15,
                                                            right: 15),
                                                        child: Text(
                                                            "Restaurant phone number",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRomanBold14AmberA700
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 10,
                                                            right: 15),
                                                        child: Text(
                                                            object
                                                                .restaurantphNo!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRegular20
                                                                .copyWith(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline)))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 15,
                                                            right: 15),
                                                        child: Text("Time Slot",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRomanBold14AmberA700
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 8,
                                                            right: 15),
                                                        child: Text(
                                                            object.timeSlot!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRegular20
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 15,
                                                            right: 15),
                                                        child: Text(
                                                            "Current Wait Time",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRomanBold14AmberA700
                                                                .copyWith()))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                        padding: getPadding(
                                                            left: 15,
                                                            top: 12,
                                                            right: 15,
                                                            bottom: 15),
                                                        child: Text(
                                                            object.currenttime!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtRobotoRegular20
                                                                .copyWith()))),
                                                object.userverified
                                                            .toString() ==
                                                        'false'
                                                    ? object.status ==
                                                            Status
                                                                .authenticating
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
                                                                if (soc ==
                                                                    'true') {
                                                                  WidgetsBinding
                                                                      .instance
                                                                      ?.addPostFrameCallback(
                                                                          (timeStamp) {
                                                                    final auth = Provider.of<
                                                                            MakeReservationProvider>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                    auth.verifyUserReservation(
                                                                        context,
                                                                        widget
                                                                            .bookingid!);
                                                                  });
                                                                } else {
                                                                  WidgetsBinding
                                                                      .instance
                                                                      ?.addPostFrameCallback(
                                                                          (timeStamp) {
                                                                    final auth = Provider.of<
                                                                            MakeReservationProvider>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                    auth.getAccessToken(
                                                                        context,
                                                                        'Verify',
                                                                        widget
                                                                            .bookingid!,
                                                                        '',
                                                                        '');
                                                                  });
                                                                }
                                                              });
                                                            },
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                    39.00,
                                                                  ),
                                                                  top:
                                                                      getVerticalSize(
                                                                    20.00,
                                                                  ),
                                                                  right:
                                                                      getHorizontalSize(
                                                                    39.00,
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
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
                                                                    'Verify',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .textstylerobotoromansemibold20
                                                                        .copyWith(
                                                                      fontSize:
                                                                          getFontSize(
                                                                        18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                    : Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left:
                                                                getHorizontalSize(
                                                              39.00,
                                                            ),
                                                            top:
                                                                getVerticalSize(
                                                              20.00,
                                                            ),
                                                            right:
                                                                getHorizontalSize(
                                                              39.00,
                                                            ),
                                                          ),
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
                                                                    .textstylerobotoromansemibold16disabled,
                                                            child: Text(
                                                              'Verify',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .textstylerobotoromansemibold162disabled
                                                                  .copyWith(
                                                                fontSize:
                                                                    getFontSize(
                                                                  18,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return CancelPopup(
                                                                widget
                                                                    .bookingid!);
                                                          });
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
                                                          15.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
                                                          39.00,
                                                        ),
                                                        bottom: getVerticalSize(
                                                          20.00,
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
                                                            .textstylerobotoromansemibold166,
                                                        child: Text(
                                                          "Cancel",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .textstylerobotoromansemibold166
                                                              .copyWith(
                                                            fontSize:
                                                                getFontSize(
                                                              18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]))),
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          height: getSize(100.00),
                                          width: getSize(100.00),
                                          margin: getMargin(
                                              left: 163,
                                              top: 5,
                                              right: 163,
                                              bottom: 10),
                                          child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 0,
                                              margin: const EdgeInsets.all(0),
                                              color: ColorConstant.amberA700,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getHorizontalSize(
                                                              50.00))),
                                              child: Stack(children: [
                                                object.profilePic == '' ||
                                                        object.profilePic ==
                                                            null
                                                    ? Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                            padding: getPadding(
                                                                left: 20,
                                                                top: 28,
                                                                right: 20,
                                                                bottom: 27),
                                                            child: SvgPicture
                                                                .asset(
                                                              ImageConstant
                                                                  .imgMaskgroup,
                                                              fit: BoxFit.fill,
                                                              width: 40,
                                                              height: 40,
                                                            )),
                                                      )
                                                    : SizedBox(
                                                        child: FittedBox(
                                                          fit: BoxFit.fill,
                                                          child: CircleAvatar(
                                                            radius:
                                                                48, // Image radius
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    object.profilePic ==
                                                                            null
                                                                        ? ''
                                                                        : object
                                                                            .profilePic!,
                                                                    scale: 2.0),
                                                          ),
                                                        ),
                                                      )
                                              ]))))
                                ]))),
                  ]),
                ]))),
      );
    });
  }
}
