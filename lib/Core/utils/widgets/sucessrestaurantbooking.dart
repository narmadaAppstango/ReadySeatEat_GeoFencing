import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/app_export.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/common-imageView.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/home-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import 'package:restaurent_seating_mobile_frontend/model/book-slot-response.dart';
import '../../../Provider/make-reservation-provider.dart';
import '../../../Provider/shared-preference.dart';

class SucessrestaurantbookingScreenDialog extends StatefulWidget {
  SucessrestaurantbookingScreenDialog(this.response, this.mode, this.mode2,
      {Key? key})
      : super(key: key);
  BookSlotsResponse response;
  String mode;
  String mode2;
  @override
  _SucessrestaurantbookingScreenDialogState createState() =>
      _SucessrestaurantbookingScreenDialogState();
}

class _SucessrestaurantbookingScreenDialogState
    extends State<SucessrestaurantbookingScreenDialog> {
  String? soc = '';
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
      soc = soclogin.toString();
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        final auth =
            Provider.of<MakeReservationProvider>(context, listen: false);
        auth.clearData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MakeReservationProvider>(builder: (context, object, child) {
      return Scaffold(
          backgroundColor: ColorConstant.black900,
          body: Stack(alignment: Alignment.topCenter, children: [
            Align(
                alignment: Alignment.centerLeft,
                child: ListView(physics: ClampingScrollPhysics(), children: [
                  Container(
                      height: size.height,
                      width: size.width,
                      margin: getMargin(top: 1),
                      decoration: AppDecoration.groupstyleblack900,
                      child: Stack(alignment: Alignment.topCenter, children: [
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                margin: getMargin(
                                    left: 25, top: 25, right: 25, bottom: 40),
                                decoration: AppDecoration.fillWhiteA700
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder40),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible:
                                            widget.mode.toString() == 'Sucess'
                                                ? true
                                                : false,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PresentReservationScreen()));
                                          },
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                  padding: getPadding(
                                                      left: 15,
                                                      top: 19,
                                                      right: 15),
                                                  child: CommonImageView(
                                                      svgPath: ImageConstant
                                                          .imgClose,
                                                      height: getSize(26.00),
                                                      width: getSize(26.00)))),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 80, right: 15),
                                              child: Center(
                                                child: Text(
                                                    widget.mode.toString() ==
                                                            'Sucess'
                                                        ? widget.mode2 ==
                                                                'update'
                                                            ? 'Your reservation is updated'
                                                            : 'Your reservation is confirmed'
                                                        : "Your reservation has \n been cancelled sucessfully",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtRobotoRomanLight24
                                                        .copyWith()),
                                              ))),
                                      Visibility(
                                        visible: widget.mode == 'Sucess'
                                            ? true
                                            : false,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: getPadding(
                                                  left: 20, top: 10, right: 15),
                                              child: Center(
                                                  child: Text(
                                                      "Please make sure to keep your app \nrunning to receive further notification",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtRobotoRomanLight24
                                                          .copyWith(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                            )),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 20, right: 15),
                                              child: Text("Reservation id",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRomanBold14AmberA700
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 12, right: 15),
                                              child: Text(
                                                  widget.response.booking!
                                                      .bookingId!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular20
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 38, right: 15),
                                              child: Text("Queue number",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRomanBold14AmberA700
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 4, right: 15),
                                              child: Text(
                                                  widget.response.booking!
                                                      .bookingId!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular20
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 38, right: 15),
                                              child: Text("Party size",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRomanBold14AmberA700
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 6, right: 15),
                                              child: Text(
                                                  widget.response.booking!
                                                          .partySize! +
                                                      ' People',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular20
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 37, right: 15),
                                              child: Text("Restaurant name",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRomanBold14AmberA700
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 7, right: 15),
                                              child: Text(
                                                  widget.response.booking!
                                                      .outletName!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular20
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 35, right: 15),
                                              child: Text(
                                                  "Restaurant phone number",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRomanBold14AmberA700
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 10, right: 15),
                                              child: Text(
                                                  widget.response.booking!
                                                      .outletPhoneNumber!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular20
                                                      .copyWith(
                                                          fontSize: 14,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 38, right: 15),
                                              child: Text("Time slot",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRomanBold14AmberA700
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 8, right: 15),
                                              child: Text(
                                                  widget.response.booking!
                                                      .slotTime!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular20
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15, top: 38, right: 15),
                                              child: Text("Current wait time",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRomanBold14AmberA700
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 15,
                                                  top: 12,
                                                  right: 15,
                                                  bottom: 35),
                                              child: Text(
                                                  widget.response.booking!
                                                      .currentWaitTime!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtRobotoRegular20
                                                      .copyWith(
                                                          fontSize: 14)))),
                                      Visibility(
                                        visible:
                                            widget.mode.toString() == 'Sucess'
                                                ? false
                                                : true,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PresentReservationScreen()));
                                          },
                                          child: Padding(
                                            padding: getPadding(
                                                left: 15,
                                                top: 0,
                                                right: 15,
                                                bottom: 10),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: getVerticalSize(
                                                  50.00,
                                                ),
                                                width: getHorizontalSize(
                                                  100.00,
                                                ),
                                                decoration: AppDecoration
                                                    .textstylerobotoromansemibold16,
                                                child: Text(
                                                  "Ok",
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .textstylerobotoromansemibold20
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
                                      ),
                                    ]))),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                height: getSize(100.00),
                                width: getSize(100.00),
                                margin: getMargin(
                                    left: 163, top: 10, right: 163, bottom: 50),
                                child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 0,
                                    // margin: EdgeInsets.all(0),
                                    color: ColorConstant.amberA700,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(50.00))),
                                    child: Stack(children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding: getPadding(
                                                  left: 20,
                                                  top: 28,
                                                  right: 20,
                                                  bottom: 27),
                                              child: CommonImageView(
                                                  svgPath: ImageConstant
                                                      .imgCheckmark,
                                                  height:
                                                      getVerticalSize(44.00),
                                                  width: getHorizontalSize(
                                                      60.00))))
                                    ]))))
                      ])),
                ]))
          ]));
    });
  }
}
