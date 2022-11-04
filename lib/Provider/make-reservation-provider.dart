import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/sucessrestaurantbooking.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/model/book-slot-response.dart';
import 'package:restaurent_seating_mobile_frontend/model/common-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/slotreservationResponse.dart';
import 'package:restaurent_seating_mobile_frontend/model/token-response-model.dart';

import '../Core/utils/widgets/warning-dialogs.dart';
import '../model/get-previous-reservationresponse.dart';
import '../model/login-response-model.dart';
import 'api-service-provider.dart';

class MakeReservationProvider extends ChangeNotifier {
  Status _status = Status.unauthenticated;

  Status get status => _status;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final TextEditingController? _dateController = TextEditingController();

  TextEditingController? get dateController => _dateController;

  final TextEditingController? _timeController = TextEditingController();

  TextEditingController? get timeController => _timeController;

  final TextEditingController? _peopleCountController = TextEditingController();

  TextEditingController? get peopleCountController => _peopleCountController;

  SlotReservationResponse? slotReservationResponse;

  SlotReservationResponse? get _slotReservationResponse =>
      slotReservationResponse;

  CommonResponseDataModel? commonResponseDataModel;

  CommonResponseDataModel? get _commonResponseDataModel =>
      commonResponseDataModel;

  BookSlotsResponse? bookSlotsResponse;

  BookSlotsResponse? get _bookSlotResponse => bookSlotsResponse;

  GetPreviousReservationsResponse? getPreviousReservationsResponse;

  GetPreviousReservationsResponse? get _getPreviousReservationsResponse =>
      getPreviousReservationsResponse;

  LoginResponseModel? _loginDataModel;

  LoginResponseModel? get loginDataModel => _loginDataModel;

  TokenResponse? _tokenResponseDataModel;

  TokenResponse? get tokenResponseModel => _tokenResponseDataModel;

  int peoplecount = 0;

  int get _peoplecount => peoplecount;

  List<Slot> slottimings = [];

  String? time = '';

  String? get _time => time;

  String? outletId = '';

  String? get _outletId => outletId;

  bool visible = false;

  bool isclicked = true;

  bool? isChecked = false;

  bool? get _ischecked => isChecked;

  String? deviceToken = '';

  String? username = '';
  String? useremail = '';
  String? userPhoneNo = '';
  String? bookingID = '';
  String? queuenumber = '';
  String? partySize = '';
  String? restaurantname = '';
  String? restaurantphNo = '';
  String? timeSlot = '';
  String? currenttime = '';
  String? profilePic = '';
  String? userverified = '';

  /* Get Acess token of current user */
  void getAccessToken(BuildContext context, String mode, String bookingId,
      String outletId, String slotid) async {
    var email = await SharedPreference().getemail();
    var password = await SharedPreference().getPassword();
    notifyListeners();
    _loginDataModel =
        await Provider.of<APIServiceProvider>(context, listen: false)
            .userLoginApi(email.toString().trim(), password.toString().trim());
    if (_loginDataModel!.status != null) {
      if (_loginDataModel?.status == false) {
        warningDialogs(context, _loginDataModel!.message);
      } else {
        final bool setToken =
            await SharedPreference().setToken(_loginDataModel!.token!);
        if (bookingId != '') {
          if (mode == 'update') {
            updateslotBooking(context, outletId, slotid, bookingId);
          } else if (mode == 'Verify') {
            verifyUserReservation(context, bookingId);
          } else {
            getpreviousreservationsdata(context, bookingId);
          }
        } else {
          if (slotid == '') {
            getSlotDetails(context, outletId);
          } else {
            slotBooking(context, outletId, slotid);
          }
        }
      }
    } else {
      warningDialogs(context, 'Internal Server Error, Please try again');
    }
  }

  /* Set all data for update */
  setresponsedata(GetPreviousReservationsResponse response) {
    dateController!.text = response.booking!.slotDate!;
    timeController!.text = response.booking!.slotTime!;
    peopleCountController!.text = response.booking!.noOfSeats!;
    outletId = response.booking!.outletid;
    peoplecount = int.parse(response.booking!.noOfSeats!);
    notifyListeners();
  }

  /* Get previous reservation data API function */
  getpreviousreservationsdata(BuildContext context, String bookingid) async {
    _status = Status.authenticating;
    notifyListeners();
    //getreservations.clear();
    _isLoading = true;
    visible = false;
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      getPreviousReservationsResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .getPreviousReservationsApi(bookingid);
      final birthday = DateTime.parse(
          getPreviousReservationsResponse!.booking!.slotdatetime.toString());
      final date2 = DateTime.now();
      final difference = birthday.difference(date2).inSeconds;
      print(difference.toString());
      int h = difference ~/ 3600;
      print(h);
      int m = ((difference - h * 3600)) ~/ 60;
      print(m);
      int s = difference - (h * 3600) - (m * 60);
      print(s);
      String result = h < 0
          ? '0'
          : h.toString() +
              'h ' +
              (m < 0 ? '0' : m.toString()) +
              'm ' +
              (s < 0 ? '0' : s.toString()) +
              's ';
      currenttime = result;
      username = getPreviousReservationsResponse!.appUserDetails!.firstName
              .toString() +
          ' ' +
          getPreviousReservationsResponse!.appUserDetails!.lastName!;
      useremail =
          getPreviousReservationsResponse!.appUserDetails!.email.toString();
      userPhoneNo = getPreviousReservationsResponse!.appUserDetails!.phoneNumber
          .toString();
      bookingID =
          getPreviousReservationsResponse!.booking!.bookingId.toString();
      queuenumber = '5019';
      partySize =
          getPreviousReservationsResponse!.booking!.noOfSeats.toString();
      restaurantname =
          getPreviousReservationsResponse!.booking!.outletName.toString();
      restaurantphNo = getPreviousReservationsResponse!
          .booking!.outletPhoneNumber
          .toString();
      profilePic =
          getPreviousReservationsResponse!.appUserDetails!.profilePicture ==
                  null
              ? ''
              : getPreviousReservationsResponse!.appUserDetails!.profilePicture
                  .toString();
      timeSlot = getPreviousReservationsResponse!.booking!.slotTime.toString();
      userverified =
          getPreviousReservationsResponse!.booking!.userverified.toString();
      _status = Status.authenticated;
      _isLoading = false;
      notifyListeners();
      if (getPreviousReservationsResponse?.status == false) {
        _isLoading = false;
        //  warningDialogs(context, _getReservationsResponse!.message);
      } else {
        setresponsedata(getPreviousReservationsResponse!);
        notifyListeners();
      }
    } else {
      _isLoading = false;
      _status = Status.unauthenticated;
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Get Slot Details validating function */

  getSlotDetails(BuildContext context, String outletId) {
    //peopleCountController!.text = peoplecount.toString();
    if (dateController!.text.isNotEmpty) {
      if (timeController!.text.isNotEmpty) {
        if (peopleCountController!.text.isNotEmpty) {
          if (double.parse(peopleCountController!.text) != 0) {
            getSlots(context, outletId);
          } else {
            warningDialogs(context, 'Please Choose more than 1 person');
          }
        } else {
          warningDialogs(context, 'Please choose the persons');
        }
      } else {
        warningDialogs(context, 'Please select valid time');
      }
    } else {
      warningDialogs(context, 'Please select the valid date');
    }
  }

  /* Slot Booking validating function */
  slotBooking(BuildContext context, String outletid, String slotid) {
    if (outletid != '') {
      if (slotid != '') {
        bookSlot(context, outletid, slotid);
      } else {
        warningDialogs(context, 'Incorrect Slot id');
      }
    } else {
      warningDialogs(context, 'Incorrect Outlet id');
    }
  }

  /* API Calling function to get device token */

  tokenCall(BuildContext context) {
    if (Platform.isIOS) {
      FirebaseMessaging.instance.getToken().then((token) {
        deviceToken = token;
        print("token dart locale>>>" + deviceToken.toString());
        sendToken(context);
      });
    } else {
      FirebaseMessaging.instance.getToken().then((token) {
        deviceToken = token;
        print("token dart locale>>>" + deviceToken.toString());
        sendToken(context);
      });
    }
    // if (!mounted) return;
  }

/* API Calling function to save the user device token */
  sendToken(BuildContext context) async {
    var uid = await SharedPreference().getUserId();
    _status = Status.authenticating;
    notifyListeners();
    _isLoading = true;
    if (deviceToken != null) {
      _tokenResponseDataModel = await Provider.of<APIServiceProvider>(context,
              listen: false)
          .sendDeviceTokenApi(uid, deviceToken, 'android');
      if (_tokenResponseDataModel!.status.toString() == 'true') {
        _status = Status.authenticated;
        _isLoading = false;
        notifyListeners();
        isChecked = _tokenResponseDataModel!.deviceToken!.status!;
        sucessDialogs(context,
            'You will be receive the notifications of the updates', '');
      } else {
        _status = Status.authenticated;
        _isLoading = false;
        //isChecked = _tokenResponseDataModel!.deviceToken!.status!;
        notifyListeners();
      }
    } else {}
  }

  /* Update Slot Booking validating function */
  updateslotBooking(
      BuildContext context, String outletid, String slotid, String bookingId) {
    if (outletid != '') {
      if (slotid != '') {
        if (bookingId != '') {
          updatebookSlot(context, outletid, slotid, bookingId);
        } else {
          warningDialogs(context, 'Incorrect Slot id');
        }
      } else {
        warningDialogs(context, 'Incorrect Slot id');
      }
    } else {
      warningDialogs(context, 'Incorrect Outlet id');
    }
  }

  /* Clear All slot Datas */
  clearData() {
    slottimings.clear();
    timeController!.text = '';
    dateController!.text = '';
    peopleCountController!.text = '0';
    peoplecount = 0;
    notifyListeners();
  }

  /* Clear reservation details*/
  clearDatas() {
    _bookSlotResponse!.booking!.bookingId = '';
    _bookSlotResponse!.booking!.currentWaitTime = '';
    _bookSlotResponse!.booking!.outletName = '';
    _bookSlotResponse!.booking!.partySize = '';
    _bookSlotResponse!.booking!.slotTime = '';
    _bookSlotResponse!.booking!.outletPhoneNumber = '';
    notifyListeners();
  }

  /* Get Slot List API function */
  getSlots(BuildContext context, String outletId) async {
    _status = Status.authenticating;
    notifyListeners();
    _isLoading = true;
    isclicked = true;
    slottimings.clear();
    visible = false;
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      slotReservationResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .getSlotDetailsAPI(outletId, dateController!.text,
                  timeController!.text, peopleCountController!.text);
      _status = Status.authenticated;
      _isLoading = false;
      notifyListeners();
      if (slotReservationResponse == null) {
        _isLoading = false;
        warningDialogs(context, 'Something went wrong');
      } else {
        if (_slotReservationResponse?.status == false) {
          _isLoading = false;
          warningDialogs(context, slotReservationResponse!.message);
        } else {
          for (int i = 0; i < _slotReservationResponse!.slots!.length; i++) {
            Slot sd = Slot();
            sd.slotStartTime =
                _slotReservationResponse!.slots![i].slotStartTime.toString();
            sd.selected = false;
            slottimings.add(sd);
          }
          if (_slotReservationResponse!.slots![0].slotAvailable == true) {
            print('visible' + visible.toString());
            visible = true;
            notifyListeners();
          } else {
            warningDialogs(context,
                'Slots are not available right now, please try again later');
          }
          notifyListeners();
        }
      }
    } else {
      _isLoading = false;
      _status = Status.unauthenticated;
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Book Slot API function */
  bookSlot(BuildContext context, String outletId, String slotId) async {
    _status = Status.authenticating;
    notifyListeners();
    _isLoading = true;
    isclicked = true;
    // slottimings.clear();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      bookSlotsResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .bookSlotsAPi(outletId, slotId);
      _status = Status.authenticated;
      _isLoading = false;
      notifyListeners();
      if (_bookSlotResponse?.status == false) {
        _isLoading = false;
        warningDialogs(context, bookSlotsResponse!.message);
      } else {
        final birthday =
            DateTime.parse(bookSlotsResponse!.booking!.slotdateTime.toString());
        final date2 = DateTime.now();
        final difference = date2.difference(birthday).inSeconds;
        int h = difference ~/ 3600;

        int m = ((difference - h * 3600)) ~/ 60;

        int s = difference - (h * 3600) - (m * 60);

        String result = (h < 0 ? '0' : h.toString()) +
            'h ' +
            (m < 0 ? '0' : m.toString()) +
            'm ' +
            (s < 0 ? '0' : s.toString()) +
            's ';

        bookSlotsResponse!.booking!.currentWaitTime = result;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SucessrestaurantbookingScreenDialog(
                    bookSlotsResponse!, 'Sucess', '')));
        notifyListeners();
      }
    } else {
      _isLoading = false;
      _status = Status.unauthenticated;
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Update Book Slot API function */
  updatebookSlot(BuildContext context, String outletId, String slotId,
      String bookingId) async {
    _status = Status.authenticating;
    notifyListeners();
    _isLoading = true;
    isclicked = true;
    // slottimings.clear();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      bookSlotsResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .updateSlotsAPi(outletId, slotId, bookingId);
      _status = Status.authenticated;
      _isLoading = false;
      notifyListeners();
      if (_bookSlotResponse?.status == false) {
        _isLoading = false;
        warningDialogs(context, bookSlotsResponse!.message);
      } else {
        final birthday =
            DateTime.parse(bookSlotsResponse!.booking!.slotdateTime.toString());
        final date2 = DateTime.now();
        final difference = date2.difference(birthday).inSeconds;
        int h = difference ~/ 3600;

        int m = ((difference - h * 3600)) ~/ 60;

        int s = difference - (h * 3600) - (m * 60);

        String result = h.abs().toString() +
            'h ' +
            m.abs().toString() +
            'm ' +
            s.abs().toString() +
            's ';
        // br.booking?.currentWaitTime = result;
        bookSlotsResponse!.booking!.currentWaitTime = result;
        notifyListeners();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SucessrestaurantbookingScreenDialog(
                    bookSlotsResponse!, 'Sucess', 'update')));
        notifyListeners();
      }
    } else {
      _isLoading = false;
      _status = Status.unauthenticated;
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Verify User Reservation API function */
  verifyUserReservation(BuildContext context, String bookingID) async {
    _status = Status.authenticating;
    notifyListeners();
    _isLoading = true;
    isclicked = true;
    slottimings.clear();
    visible = false;
    var netStatus = await SharedPreference().getinternetstatus();
    var userid = await SharedPreference().getUserId();
    if (netStatus.toString() != '') {
      commonResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .verifyUserReservationAPI(
        bookingID,
      );
      _status = Status.authenticated;
      _isLoading = false;
      notifyListeners();
      if (commonResponseDataModel == null) {
        _isLoading = false;
        warningDialogs(context, 'Something went wrong');
      } else {
        if (commonResponseDataModel?.status == false) {
          _isLoading = false;
        } else {
          // var devicetoken = '';
          // tokenCall() async {
          //   FirebaseMessaging.instance.getToken().then((token) {
          //     devicetoken = token!;
          //     print("token dart locale>>>" + devicetoken.toString());
          //   });
          //   _tokenResponseDataModel =
          //       await Provider.of<APIServiceProvider>(context, listen: false)
          //           .sendDeviceTokenApi(
          //               userid.toString().trim(), devicetoken, Platform.isIOS?'android':'ios')
          //           .then((value) async => _tokenResponseDataModel =
          //               await Provider.of<APIServiceProvider>(context,
          //                       listen: false)
          //                   .sendPushNotifiApi(userid.toString().trim()));
          // }

          sucessDialogs(context, commonResponseDataModel!.message, 'Verify');
        }
      }
    } else {
      _isLoading = false;
      _status = Status.unauthenticated;
      warningDialogs(context, 'You are currently offline');
    }
  }
}
