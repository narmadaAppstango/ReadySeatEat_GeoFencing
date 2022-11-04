import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/math_utils.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/get-reservation-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/home-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import 'package:restaurent_seating_mobile_frontend/model/book-slot-response.dart';

import '../../../Provider/forget-password-provider.dart';
import '../../../theme/app_decoration.dart';
import '../../../theme/app_style.dart';

class CancelPopup extends StatefulWidget {
  CancelPopup(this.bookingId, {Key? key}) : super(key: key);
  String bookingId;
  @override
  _CancelPopupState createState() => _CancelPopupState();
}

class _CancelPopupState extends State<CancelPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, widget.bookingId),
    );
  }

  contentBox(context, String bookingId) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Text("Are you sure you want to cancel\nthis reservation?",
                  //overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppStyle.textstylepoppinsregular15
                      .copyWith(fontSize: 15)),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                        decoration:
                            AppDecoration.textstylerobotoromansemibold166,
                        child: Text(
                          "No".toUpperCase(),
                          textAlign: TextAlign.left,
                          style:
                              AppStyle.textstylerobotoromansemibold166.copyWith(
                            color: ColorConstant.whiteA700,
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
                      setState(() {
                        WidgetsBinding.instance
                            ?.addPostFrameCallback((timeStamp) {
                          final auth = Provider.of<GetReservationProvider>(
                              context,
                              listen: false);
                          auth.cancelreservationsdata(context, bookingId);
                        });
                      });
                    },
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
                        decoration:
                            AppDecoration.textstylerobotoromansemibold16,
                        child: Text(
                          "Yes".toUpperCase(),
                          textAlign: TextAlign.left,
                          style:
                              AppStyle.textstylerobotoromansemibold20.copyWith(
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
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: SvgPicture.asset("assets/images/img_group42.svg")),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
