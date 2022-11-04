import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import '../Core/utils/color_constant.dart';
import '../Core/utils/image_constant.dart';
import '../Core/utils/widgets/warning-dialogs.dart';
import '../core/utils/math_utils.dart';
import '../theme/app_style.dart';
import 'dart:async';

class AccountConfirmedScreen extends StatefulWidget {
  const AccountConfirmedScreen({Key? key}) : super(key: key);

  @override
  _AccountConfirmedState createState() => _AccountConfirmedState();
}

class _AccountConfirmedState extends State<AccountConfirmedScreen> {
  var counter = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  
  /* Load datas into the screen initial stage */
  
  _loadInitial() async {
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
    Timer.periodic(Duration(seconds: 2), (timer) {
      counter--;
      if (counter == 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const SignInScreen()),
            (Route<dynamic> route) => true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: ColorConstant.black900,
        body: SizedBox(
          width: size.width,
          child: Container(
            height: getVerticalSize(
              892.00,
            ),
            width: size.width,
            decoration: BoxDecoration(
              color: ColorConstant.black900,
            ),
            child: ListView(
              physics:const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: getHorizontalSize(
                      139.00,
                    ),
                    top: getVerticalSize(
                      88.00,
                    ),
                    right: getHorizontalSize(
                      139.00,
                    ),
                  ),
                  child: SvgPicture.asset(
                    "assets/icon/logos.svg",
                    height: getVerticalSize(
                      160,
                    ),
                    width: getHorizontalSize(
                      100.00,
                    ),
                    //fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: getVerticalSize(
                        75.61,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              110.00,
                            ),
                            top: getVerticalSize(
                              37.00,
                            ),
                            right: getHorizontalSize(
                              110.00,
                            ),
                          ),
                          child: Text(
                            accountConfirmed,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style:
                                AppStyle.textstylerobotoromanlight24.copyWith(
                              fontSize: getFontSize(
                                24,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              110.00,
                            ),
                            top: getVerticalSize(
                              105.00,
                            ),
                            right: getHorizontalSize(
                              110.00,
                            ),
                          ),
                          child: Image.asset(
                            ImageConstant.imgIcons8done1,
                            height: getSize(
                              200.00,
                            ),
                            width: getSize(
                              200.00,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              70.00,
                            ),
                            top: getVerticalSize(
                              105.00,
                            ),
                            right: getHorizontalSize(
                              70.00,
                            ),
                            bottom: getVerticalSize(
                              60.00,
                            ),
                          ),
                          child: Text(
                            rerouteToSignIn,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppStyle.textstylerobotoromansemibold18
                                .copyWith(
                              fontSize: getFontSize(
                                18,
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
      ),
    );
  }
}
