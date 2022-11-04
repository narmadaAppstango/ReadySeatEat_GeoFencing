import 'dart:async';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/app_export.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/common-imageView.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/custom-icon-button.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/make-reservation-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/edit-profile-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import 'package:restaurent_seating_mobile_frontend/model/slotreservationResponse.dart';
import '../Core/utils/widgets/warning-dialogs.dart';
import '../Provider/logout-provider.dart';
import '../Provider/shared-preference.dart';
import 'change-password-screen.dart';
import 'package:intl/intl.dart';

class MakeaReservationScreen extends StatefulWidget {
  MakeaReservationScreen(this.title, this.outletid, this.bookingid, {Key? key})
      : super(key: key);
  String title;
  String outletid;
  String bookingid;
  @override
  _MakeaReservationScreenState createState() => _MakeaReservationScreenState();
}

class _MakeaReservationScreenState extends State<MakeaReservationScreen> {
  int peopleCount = 4;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int selectedindex = -1;
  bool selected = false;
  List<int> _selectedIndexs = [];
  List<bool> widgetActive = List.generate(10, (index) {
    return false;
  });

  bool visible = false;
  bool check = false;
  String soc = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      _loadInitial();
    });
  }

  toggle(List<Slot> data, int index) {
    setState(() {});
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
      if (widget.title == 'Edit Reservation') {
        if (soc == 'true') {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            final auth =
                Provider.of<MakeReservationProvider>(context, listen: false);
            auth.getpreviousreservationsdata(context, widget.bookingid);
          });
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            final auth =
                Provider.of<MakeReservationProvider>(context, listen: false);
            auth.getAccessToken(context, '', widget.bookingid, '', '');
          });
        }
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
          child: Scaffold(
              backgroundColor: ColorConstant.black900,
              appBar: AppBar(
                backgroundColor: ColorConstant.black900,
                title: widget.title.toString() == 'Book Reserve'
                    ? const Text('Restaurant details')
                    : const Text('Edit reservation'),
                automaticallyImplyLeading: false,
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PresentReservationScreen()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: ColorConstant.amberA700,
                  ),
                ),
                actions: [
                  Padding(
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
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                    decoration: AppDecoration.fillWhiteA700
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .customBorderTL5012),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              DateTime date = DateTime.now();
                                              DateTime? newDate =
                                                  await showDatePicker(
                                                context: context,
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(new Duration(days: 3)),
                                                initialDate: DateTime.now(),
                                              );
                                              setState(() {
                                                date = newDate!;
                                                String date1 = DateFormat(
                                                        'd MMM' ',' ' yyyy')
                                                    .format(date)
                                                    .toString();
                                                print(date1);
                                                object.dateController!.text =
                                                    date1.toString();
                                              });
                                            },
                                            child: Container(
                                                width: 350,
                                                margin: const EdgeInsets.only(
                                                    left: 33,
                                                    top: 20,
                                                    right: 33),
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  top: 19,
                                                                  bottom: 17),
                                                          child: Row(children: [
                                                            CommonImageView(
                                                                svgPath:
                                                                    ImageConstant
                                                                        .imgCalendar,
                                                                height: 24,
                                                                width: 24.00),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            18,
                                                                        top: 2,
                                                                        bottom:
                                                                            3),
                                                                child: Text(
                                                                    object
                                                                        .dateController!
                                                                        .text
                                                                        .toString(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtRobotoRomanRegular16
                                                                        .copyWith()))
                                                          ])),
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
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {},
                                                                  child: CommonImageView(
                                                                      svgPath:
                                                                          'assets/images/dropdownvector.svg'),
                                                                ),
                                                              ]))
                                                    ])),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              TimeOfDay time = TimeOfDay.now();
                                              if (object.dateController!.text
                                                  .isNotEmpty) {
                                                TimeOfDay? newTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: time,
                                                );
                                                setState(() {
                                                  time = newTime!;
                                                  var t = time.hour < 10
                                                      ? '0' +
                                                          time.hour.toString()
                                                      : time.hour;
                                                  var m = time.minute < 10
                                                      ? '0' +
                                                          time.minute.toString()
                                                      : time.minute;
                                                  object.timeController!.text =
                                                      t.toString() +
                                                          ':' +
                                                          m.toString();

                                                  var parsedDate =
                                                      DateFormat('dd MMM, yyyy')
                                                          .parse(object
                                                              .dateController!
                                                              .text
                                                              .toString());
                                                  String date =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(parsedDate)
                                                          .toString();
                                                  object.timeController!
                                                      .text = DateFormat
                                                          .jm()
                                                      .format(DateTime.parse(
                                                          date +
                                                              'T' +
                                                              object
                                                                  .timeController!
                                                                  .text
                                                                  .toString() +
                                                              ":22"))
                                                      .toString();
                                                  DateTime parseDate = DateFormat(
                                                          'yyyy-MM-dd ' +
                                                              'hh:mm a')
                                                      .parse(date +
                                                          ' ' +
                                                          object.timeController!
                                                              .text
                                                              .toString());
                                                  if (parseDate.isAfter(
                                                      DateTime.now().subtract(
                                                          const Duration(
                                                              minutes: 2)))) {
                                                    var time =
                                                        DateFormat('hh:mma');
                                                    var outTime =
                                                        time.format(parseDate);
                                                    //   print(
                                                    //       'Hello time' + outTime);
                                                    object.time = outTime;
                                                  } else {
                                                    object.timeController!
                                                        .text = '';
                                                    object.time = '     ';
                                                    warningDialogs(context,
                                                        "Please choose a time from future.");
                                                  }
                                                });
                                              } else {
                                                warningDialogs(context,
                                                    'Please select the date');
                                              }
                                            },
                                            child: Container(
                                                width: 350,
                                                margin: const EdgeInsets.only(
                                                    left: 33,
                                                    top: 20,
                                                    right: 33),
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  top: 19,
                                                                  bottom: 17),
                                                          child: Row(children: [
                                                            CommonImageView(
                                                                svgPath:
                                                                    ImageConstant
                                                                        .imgClock,
                                                                height: 24,
                                                                width: 24.00),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            18,
                                                                        top: 2,
                                                                        bottom:
                                                                            3),
                                                                child: Text(
                                                                    object
                                                                        .timeController!
                                                                        .text
                                                                        .toString(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .txtRobotoRomanRegular16
                                                                        .copyWith()))
                                                          ])),
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
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {},
                                                                  child: CommonImageView(
                                                                      svgPath:
                                                                          'assets/images/dropdownvector.svg'),
                                                                ),
                                                              ]))
                                                    ])),
                                          ),
                                          Container(
                                              width: 350,
                                              margin: const EdgeInsets.only(
                                                  left: 33, top: 20, right: 33),
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                top: 19,
                                                                bottom: 17),
                                                        child: Row(children: [
                                                          CommonImageView(
                                                              svgPath:
                                                                  ImageConstant
                                                                      .imgUser1,
                                                              height: 24,
                                                              width: 24.00),
                                                          Padding(
                                                              padding: const EdgeInsets
                                                                      .only(
                                                                  left: 18,
                                                                  top: 2,
                                                                  bottom: 3),
                                                              child: Text(
                                                                  object.peopleCountController!
                                                                          .text
                                                                          .toString() +
                                                                      " People",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppStyle
                                                                      .txtRobotoRomanRegular16
                                                                      .copyWith()))
                                                        ])),
                                                    Padding(
                                                        padding: getPadding(
                                                            top: 14,
                                                            right: 13,
                                                            bottom: 14),
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (object
                                                                            .peoplecount >
                                                                        0) {
                                                                      object.peoplecount =
                                                                          object.peoplecount -
                                                                              1;
                                                                      object.peopleCountController!
                                                                              .text =
                                                                          object
                                                                              .peoplecount
                                                                              .toString();
                                                                    } else {
                                                                      object.peoplecount =
                                                                          0;
                                                                      object.peopleCountController!
                                                                              .text =
                                                                          object
                                                                              .peoplecount
                                                                              .toString();
                                                                      print(
                                                                          'You cannot able to minimize the people less than 0');
                                                                    }
                                                                    object.peopleCountController!
                                                                            .text =
                                                                        object
                                                                            .peoplecount
                                                                            .toString();
                                                                  });
                                                                },
                                                                child: CustomIconButton(
                                                                    height: 32,
                                                                    width: 32,
                                                                    variant:
                                                                        IconButtonVariant
                                                                            .FillBlack901,
                                                                    shape: IconButtonShape
                                                                        .CircleBorder16,
                                                                    padding:
                                                                        IconButtonPadding
                                                                            .PaddingAll7,
                                                                    child: CommonImageView(
                                                                        svgPath:
                                                                            ImageConstant.imgPeopleminus)),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    print(object
                                                                        .peoplecount);
                                                                    object.peopleCountController!
                                                                            .text =
                                                                        object
                                                                            .peoplecount
                                                                            .toString();
                                                                    if (object
                                                                            .peoplecount <
                                                                        20) {
                                                                      object.peoplecount =
                                                                          object.peoplecount +
                                                                              1;
                                                                      object.peopleCountController!
                                                                              .text =
                                                                          object
                                                                              .peoplecount
                                                                              .toString();
                                                                    }
                                                                  });
                                                                },
                                                                child: CustomIconButton(
                                                                    height: 32,
                                                                    width: 32,
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8),
                                                                    variant:
                                                                        IconButtonVariant
                                                                            .FillBlack901,
                                                                    shape: IconButtonShape
                                                                        .CircleBorder16,
                                                                    padding:
                                                                        IconButtonPadding
                                                                            .PaddingAll7,
                                                                    child: CommonImageView(
                                                                        svgPath:
                                                                            ImageConstant.imgPeopleplus)),
                                                              )
                                                            ]))
                                                  ])),
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
                                                      //visible = !visible;
                                                      if (object.isclicked ==
                                                          true) {
                                                        print('Click' +
                                                            object.isclicked
                                                                .toString());
                                                        object.isclicked =
                                                            false;
                                                        if (widget.bookingid !=
                                                            '') {
                                                          if (soc.toString() ==
                                                              'true') {
                                                            object.getSlotDetails(
                                                                context,
                                                                object
                                                                    .getPreviousReservationsResponse!
                                                                    .booking!
                                                                    .outletid!);
                                                          } else {
                                                            object.getAccessToken(
                                                                context,
                                                                '',
                                                                '',
                                                                object
                                                                    .getPreviousReservationsResponse!
                                                                    .booking!
                                                                    .outletid!,
                                                                '');
                                                          }
                                                        } else {
                                                          if (soc.toString() ==
                                                              'true') {
                                                            object.getSlotDetails(
                                                                context,
                                                                widget
                                                                    .outletid);
                                                          } else {
                                                            object.getAccessToken(
                                                                context,
                                                                '',
                                                                '',
                                                                widget.outletid,
                                                                '');
                                                          }
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
                                                          20.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
                                                          39.00,
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
                                                          findtimeSlot,
                                                          textAlign:
                                                              TextAlign.left,
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
                                                ),
                                          Padding(
                                              padding: getPadding(
                                                  left: 10,
                                                  top: 20,
                                                  right: 37,
                                                  bottom: 10),
                                              child: SizedBox(
                                                height: getVerticalSize(120),
                                                child: GridView.builder(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: object
                                                                    .slottimings
                                                                    .length ==
                                                                1
                                                            ? 1
                                                            : 3,
                                                        crossAxisSpacing: 5,
                                                        mainAxisExtent: 55),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount: object
                                                        .slottimings.length,
                                                    key: UniqueKey(),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      // final _isSelected =
                                                      //     _selectedIndexs
                                                      //         .contains(index);
                                                      return Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              for (int i = 0;
                                                                  i <
                                                                      object
                                                                          .slottimings
                                                                          .length;
                                                                  i++) {
                                                                if (i ==
                                                                    index) {
                                                                  object
                                                                      .slottimings[
                                                                          i]
                                                                      .selected = true;
                                                                } else {
                                                                  object
                                                                      .slottimings[
                                                                          i]
                                                                      .selected = false;
                                                                }
                                                              }

                                                              selectedindex =
                                                                  index;
                                                            });
                                                          },
                                                          child: Container(
                                                            width:
                                                                getHorizontalSize(
                                                              110.00,
                                                            ),
                                                            margin: getMargin(
                                                                left: 10,
                                                                right: 5,
                                                                top: 10,
                                                                bottom: 10),
                                                            padding: getPadding(
                                                              left: 20,
                                                              top: 10,
                                                              right: 10,
                                                              bottom: 10,
                                                            ),
                                                            decoration: object
                                                                        .slotReservationResponse!
                                                                        .slots![
                                                                            index]
                                                                        .slotAvailable ==
                                                                    true
                                                                ? object.slottimings[index].selected ==
                                                                        true
                                                                    ? AppDecoration
                                                                        .txtOutlineorange9003f12
                                                                        .copyWith(
                                                                            borderRadius: BorderRadiusStyle
                                                                                .txtCircleBorder20)
                                                                    : AppDecoration
                                                                        .txtOutlineBlack9003f12
                                                                        .copyWith(
                                                                            borderRadius: BorderRadiusStyle
                                                                                .txtCircleBorder20)
                                                                : AppDecoration
                                                                    .txtOutlineBlack9003f
                                                                    .copyWith(
                                                                    borderRadius:
                                                                        BorderRadiusStyle
                                                                            .txtCircleBorder20,
                                                                  ),
                                                            child: Text(
                                                              object
                                                                  .slottimings[
                                                                      index]
                                                                  .slotStartTime
                                                                  .toString(),
                                                              maxLines: null,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .txtRobotoRomanSemiBold16WhiteA700
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              )),
                                          Visibility(
                                            visible: object.visible,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 10,
                                                    top: 10,
                                                    right: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Theme(
                                                        data: ThemeData(
                                                            unselectedWidgetColor:
                                                                ColorConstant
                                                                    .amberA700),
                                                        child: Transform.scale(
                                                          scale: 1.2,
                                                          child: Checkbox(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.0),
                                                              ),
                                                              value: object
                                                                  .isChecked,
                                                              materialTapTargetSize:
                                                                  MaterialTapTargetSize
                                                                      .padded,
                                                              checkColor:
                                                                  ColorConstant
                                                                      .black900,
                                                              activeColor:
                                                                  ColorConstant
                                                                      .amberA700,
                                                              hoverColor:
                                                                  ColorConstant
                                                                      .amberA700,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  object.isChecked =
                                                                      value!;
                                                                  print('check' +
                                                                      object
                                                                          .isChecked
                                                                          .toString());
                                                                  if (object
                                                                          .isChecked ==
                                                                      true) {
                                                                    object.tokenCall(
                                                                        context);
                                                                  } else {}
                                                                });
                                                              }),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding: getPadding(
                                                            left: 5,
                                                          ),
                                                          child: Text(
                                                              receiveNotificationText,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left))
                                                    ])),
                                          ),
                                          object.visible == true
                                              ? object.status ==
                                                      Status.authenticating
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
                                                          if (object
                                                                  .isclicked ==
                                                              true) {
                                                            print('Click' +
                                                                object.isclicked
                                                                    .toString());
                                                            object.isclicked =
                                                                false;
                                                            if (selectedindex >
                                                                -1) {
                                                              if (widget
                                                                      .bookingid !=
                                                                  '') {
                                                                if (soc.toString() ==
                                                                    'true') {
                                                                  object.updateslotBooking(
                                                                      context,
                                                                      object
                                                                          .getPreviousReservationsResponse!
                                                                          .booking!
                                                                          .outletid!,
                                                                      object
                                                                          .slotReservationResponse!
                                                                          .slots![
                                                                              selectedindex]
                                                                          .slotId!,
                                                                      widget
                                                                          .bookingid);
                                                                } else {
                                                                  object.getAccessToken(
                                                                      context,
                                                                      'update',
                                                                      widget
                                                                          .bookingid,
                                                                      object
                                                                          .getPreviousReservationsResponse!
                                                                          .booking!
                                                                          .outletid!,
                                                                      object
                                                                          .slotReservationResponse!
                                                                          .slots![
                                                                              selectedindex]
                                                                          .slotId!);
                                                                }
                                                              } else {
                                                                if (soc.toString() ==
                                                                    'true') {
                                                                  object.slotBooking(
                                                                      context,
                                                                      widget
                                                                          .outletid,
                                                                      object
                                                                          .slotReservationResponse!
                                                                          .slots![
                                                                              selectedindex]
                                                                          .slotId!);
                                                                } else {
                                                                  object.getAccessToken(
                                                                      context,
                                                                      '',
                                                                      '',
                                                                      widget
                                                                          .outletid,
                                                                      object
                                                                          .slotReservationResponse!
                                                                          .slots![
                                                                              selectedindex]
                                                                          .slotId!);
                                                                }
                                                              }
                                                            } else {
                                                              warningDialogs(
                                                                  context,
                                                                  'Please select the available slot');
                                                            }
                                                          }
                                                        });
                                                      },
                                                      child: Align(
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
                                                                    .textstylerobotoromansemibold16,
                                                            child: Text(
                                                              widget.bookingid !=
                                                                      ''
                                                                  ? 'Save'
                                                                  : reservedseat,
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
                                                    ),
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
                                                          .textstylerobotoromansemibold16disabled,
                                                      child: Text(
                                                          widget.bookingid != ''
                                                              ? 'Save'
                                                              : reservedseat,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .textstylerobotoromansemibold20disabled
                                                              .copyWith(
                                                                  fontSize:
                                                                      getFontSize(
                                                            18,
                                                          ))),
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
                                                    15.00,
                                                  ),
                                                  right: getHorizontalSize(
                                                    39.00,
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
                                        ]))),
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
                          ])))));
    });
  }
}
