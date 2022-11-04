import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plain_notification_token/plain_notification_token.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-in-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/Sign-In-Screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/create-profile-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/home-screen.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import 'package:restaurent_seating_mobile_frontend/model/login-response-model.dart';

import '../Core/utils/widgets/warning-dialogs.dart';
import '../Provider/api-service-provider.dart';
import '../model/token-response-model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Animation? animation;

  double beginAnim = 0.0;
  double endAnim = 2.0;

  startTime() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    _loadInitial();
  }

  /* Login Response Model */
  LoginResponseModel? _loginResponseDataModel;
  TokenResponse? _tokenResponseDataModel;
  var devicetoken;

  LoginResponseModel? get loginResponseDataModel => _loginResponseDataModel;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    startTime();
    // tokenCall();
  }

 

  /* Load datas into the screen initial stage */

  _loadInitial() async {
    var email = await SharedPreference().getemail();
    var pasword = await SharedPreference().getPassword();
    var socialLogin = await SharedPreference().getSignedin();
    var socialName = await SharedPreference().getsocialloginName();
    var id = await SharedPreference().getUserId();

    if (socialLogin.toString() != 'true') {
      if (email.toString() != '' && pasword.toString() != '') {
        _loginResponseDataModel = await Provider.of<APIServiceProvider>(context,
                listen: false)
            .userLoginApi(email.toString().trim(), pasword.toString().trim());
      }
    }
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
      if (socialLogin.toString() == 'true') {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final auth = Provider.of<SigninProvider>(context, listen: false);
          auth.getsocialSignIn(context, socialName.toString());
        });
      } else {
        if (email.toString().trim() != '' && pasword.toString().trim() != '') {
          if (_loginResponseDataModel!.status == true) {
            if (_loginResponseDataModel?.value?.profilecreated == true) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const PresentReservationScreen()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CreateProfileScreen()));
            }
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SignInScreen()));
          }
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const SignInScreen()));
        }
      }
    });
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.black, Colors.black],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icon/logos.svg",
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width / 2.5,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 32.0, right: 32.0, top: 16.0, bottom: 16),
                          child: LinearProgressIndicator(
                            minHeight: 6,
                            value: animation?.value,
                            backgroundColor: Colors.grey,
                            color: Colors.amber,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            'Loading...',
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
            color: Colors.black,
            margin: const EdgeInsets.only(bottom: 15.0),
            height: 60.0,
            child: const Center(
              child: Text(
                "Copyright © 2022 Ready Seat Eat",
                style: TextStyle(
                  letterSpacing: .6,
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )));
  }
}
