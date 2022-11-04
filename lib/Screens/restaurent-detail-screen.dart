import 'dart:async';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/get-restaurent-detailsProvider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/logout-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/change-password-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/edit-profile-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/home-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/make-a-reservation.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/notification-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import 'package:restaurent_seating_mobile_frontend/model/outlet-search-response.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_decoration.dart';
import 'package:restaurent_seating_mobile_frontend/theme/app_style.dart';
import '../Core/utils/color_constant.dart';
import '../Core/utils/math_utils.dart';
import '../core/utils/image_constant.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  const RestaurantDetailsScreen(this.restaurentid, this.route, {Key? key})
      : super(key: key);
  final String restaurentid;
  final String route;
  @override
  _RestaurentDetailsScreenState createState() =>
      _RestaurentDetailsScreenState();
}

class _RestaurentDetailsScreenState extends State<RestaurantDetailsScreen> {
  bool isvisible = false;
  String soc = '';
  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

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
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        final auth =
            Provider.of<GetRestaurentDetailsProvider>(context, listen: false);
        auth.clearData();
      });
      if (widget.restaurentid.isNotEmpty || widget.restaurentid != '') {
        if (soc == 'true') {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            final auth = Provider.of<GetRestaurentDetailsProvider>(context,
                listen: false);
            auth.getRestaurentdetails(context, widget.restaurentid.toString());
          });
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            final auth = Provider.of<GetRestaurentDetailsProvider>(context,
                listen: false);
            auth.getAccessToken(context, widget.restaurentid, 'ResDet');
          });
        }
      }
    });
  }

  final List<String> _imageList = [
    'https://i.stack.imgur.com/AAxpw.png',
    'https://i.stack.imgur.com/AAxpw.png',
    'https://i.stack.imgur.com/AAxpw.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRestaurentDetailsProvider>(
        builder: (context, object, child) {
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
              title: const Text('Restaurant details'),
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             const PresentReservationScreen()));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorConstant.amberA700,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationsScreen()));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 18, bottom: 18, left: 10),
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
                                width: size.width * 0.44,
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
                                width: size.width * 0.44,
                                height: 1,
                              ),
                            )
                          ],
                        )),
                    // PopupMenuItem(
                    //     value: 2,
                    //     padding: EdgeInsets.zero,
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 8.0),
                    //               child: SvgPicture.asset(
                    //                 ImageConstant.resetpassword,
                    //                 fit: BoxFit.fill,
                    //               ),
                    //             ),
                    //             const Padding(
                    //               padding:
                    //                   EdgeInsets.only(left: 8.0, right: 2.0),
                    //               child: Text('Reset Password'),
                    //             ),
                    //           ],
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(
                    //             top: 8.0,
                    //           ),
                    //           child: Container(
                    //             color: ColorConstant.black90040,
                    //             width: size.width * 0.37,
                    //             height: 1,
                    //           ),
                    //         )
                    //       ],
                    //     )),
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
                                width: size.width * 0.44,
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
                                width: size.width * 0.44,
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
                                width: size.width * 0.44,
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
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SvgPicture.asset(
                                ImageConstant.imgGroup,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 2.0),
                              child: Text('Logout'),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
            body: SizedBox(
              width: size.width,
              height: size.height,
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
                              width: double.infinity,
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
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteA700,
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
                                                45.00,
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
                                                controller:
                                                    object.restaurentName,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: "Restaurant name",
                                                  hintStyle: AppStyle
                                                      .textstylerobotoromanregular16
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      22.0,
                                                    ),
                                                    color:
                                                        ColorConstant.gray900,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        30.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: ColorConstant
                                                          .bluegray100,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        30.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: ColorConstant
                                                          .bluegray100,
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
                                                        ImageConstant
                                                            .imgCarbonrestaurant,
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
                                                  filled: true,
                                                  fillColor:
                                                      ColorConstant.whiteA700,
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
                                                    22.0,
                                                  ),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: getVerticalSize(
                                                32.00,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      39.00,
                                                    ),
                                                    right: getHorizontalSize(
                                                      39.00,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Restaurant images",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .textstylerobotoromanregular161
                                                        .copyWith(
                                                      fontSize: getFontSize(
                                                        22,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: getVerticalSize(
                                                    1.00,
                                                  ),
                                                  width: getHorizontalSize(
                                                    347.00,
                                                  ),
                                                  margin: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      39.00,
                                                    ),
                                                    top: getVerticalSize(
                                                      12.00,
                                                    ),
                                                    right: getHorizontalSize(
                                                      39.00,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.black900,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      00.00,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.7,
                                                        height:
                                                            _imageList.length <
                                                                    4
                                                                ? 80
                                                                : 120,
                                                        child:
                                                            object.image.isEmpty
                                                                ? const Center(
                                                                    child:
                                                                        SizedBox(
                                                                      child: Text(
                                                                          'No Images Available'),
                                                                    ),
                                                                  )
                                                                : SizedBox(
                                                                    height: 50,
                                                                    child: GridView
                                                                        .builder(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              40.0),
                                                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              3,
                                                                          crossAxisSpacing:
                                                                              2,
                                                                          mainAxisExtent:
                                                                              80),
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      shrinkWrap:
                                                                          true,
                                                                      key:
                                                                          UniqueKey(),
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            top:
                                                                                12.0,
                                                                            bottom:
                                                                                8,
                                                                          ),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5), // Image border
                                                                            child:
                                                                                Image.network(
                                                                              object.image[index],
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      itemCount: object
                                                                          .image
                                                                          .length,
                                                                    ),
                                                                  ),
                                                      ),
                                                      // Visibility(
                                                      //   visible: object.image
                                                      //               .length <
                                                      //           2
                                                      //       ? false
                                                      //       : true,
                                                      //   child: Container(
                                                      //       height: getSize(
                                                      //         78.00,
                                                      //       ),
                                                      //       width: getSize(
                                                      //         78.00,
                                                      //       ),
                                                      //       margin:
                                                      //           EdgeInsets.only(
                                                      //         left:
                                                      //             getHorizontalSize(
                                                      //           12.00,
                                                      //         ),
                                                      //         right:
                                                      //             getHorizontalSize(
                                                      //           37.00,
                                                      //         ),
                                                      //       ),
                                                      //       decoration:
                                                      //           BoxDecoration(
                                                      //         color:
                                                      //             ColorConstant
                                                      //                 .yellow100,
                                                      //         borderRadius:
                                                      //             BorderRadius
                                                      //                 .circular(
                                                      //           getHorizontalSize(
                                                      //             4.00,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //       child: Card(
                                                      //           clipBehavior: Clip
                                                      //               .antiAlias,
                                                      //           elevation: 0,
                                                      //           margin:
                                                      //               const EdgeInsets
                                                      //                   .all(0),
                                                      //           color: ColorConstant
                                                      //               .yellow100,
                                                      //           shape:
                                                      //               RoundedRectangleBorder(
                                                      //             borderRadius:
                                                      //                 BorderRadius
                                                      //                     .circular(
                                                      //               getHorizontalSize(
                                                      //                 4.00,
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //           child: Stack(
                                                      //               children: [
                                                      //                 Align(
                                                      //                   alignment:
                                                      //                       Alignment.center,
                                                      //                   child:
                                                      //                       Padding(
                                                      //                     padding:
                                                      //                         EdgeInsets.only(
                                                      //                       left:
                                                      //                           getHorizontalSize(
                                                      //                         6.00,
                                                      //                       ),
                                                      //                       top:
                                                      //                           getVerticalSize(
                                                      //                         6.00,
                                                      //                       ),
                                                      //                       right:
                                                      //                           getHorizontalSize(
                                                      //                         6.00,
                                                      //                       ),
                                                      //                       bottom:
                                                      //                           getVerticalSize(
                                                      //                         6.00,
                                                      //                       ),
                                                      //                     ),
                                                      //                     child:
                                                      //                         Container(
                                                      //                       height:
                                                      //                           getSize(
                                                      //                         66.00,
                                                      //                       ),
                                                      //                       width:
                                                      //                           getSize(
                                                      //                         66.00,
                                                      //                       ),
                                                      //                       child:
                                                      //                           SvgPicture.asset(
                                                      //                         ImageConstant.imgFluentimagead,
                                                      //                         fit: BoxFit.fill,
                                                      //                       ),
                                                      //                     ),
                                                      //                   ),
                                                      //                 ),
                                                      //               ]))),
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                39.00,
                                              ),
                                              top: getVerticalSize(
                                                22.00,
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
                                                controller: object.address,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Restaurant address",
                                                  hintStyle: AppStyle
                                                      .textstylerobotoromanregular16
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      22.0,
                                                    ),
                                                    color:
                                                        ColorConstant.gray900,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        30.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: ColorConstant
                                                          .bluegray100,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        30.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: ColorConstant
                                                          .bluegray100,
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
                                                        ImageConstant.imgMappin,
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
                                                  filled: true,
                                                  fillColor:
                                                      ColorConstant.whiteA700,
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: getVerticalSize(
                                                            19.48,
                                                          ),
                                                          bottom:
                                                              getVerticalSize(
                                                            19.48,
                                                          ),
                                                          right:
                                                              getVerticalSize(
                                                                  10)),
                                                ),
                                                style: TextStyle(
                                                  color: ColorConstant.gray900,
                                                  fontSize: getFontSize(
                                                    22.0,
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
                                                40.00,
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
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Restaurant conatct no",
                                                  hintStyle: AppStyle
                                                      .textstylerobotoromanregular16
                                                      .copyWith(
                                                    fontSize: getFontSize(
                                                      22.0,
                                                    ),
                                                    color:
                                                        ColorConstant.gray900,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        30.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: ColorConstant
                                                          .bluegray100,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        30.00,
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: ColorConstant
                                                          .bluegray100,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        13.00,
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
                                                        ImageConstant.imgPhone1,
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
                                                  filled: true,
                                                  fillColor:
                                                      ColorConstant.whiteA700,
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      19.48,
                                                    ),
                                                    right: getHorizontalSize(
                                                      30.00,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      19.48,
                                                    ),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  color: ColorConstant.gray900,
                                                  fontSize: getFontSize(
                                                    22.0,
                                                  ),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MakeaReservationScreen(
                                                                'Book Reserve',
                                                                object.outletid,
                                                                '')));
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
                                                    40.00,
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
                                                    "Make a reservation",
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .textstylerobotoromansemibold20
                                                        .copyWith(
                                                      fontSize: getFontSize(
                                                        18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PresentReservationScreen()));
                                            },
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
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
                                                  bottom: getVerticalSize(
                                                    63.00,
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
                                                      .textstylerobotoromansemibold166,
                                                  child: Text(
                                                    "Cancel",
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .textstylerobotoromansemibold166
                                                        .copyWith(
                                                      fontSize: getFontSize(
                                                        18,
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
                                                child: SizedBox(
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
        ),
      );
    });
  }
}
