import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/sucessrestaurantbooking.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/model/book-slot-response.dart';
import 'package:restaurent_seating_mobile_frontend/model/get-previous-reservationresponse.dart';
import 'package:restaurent_seating_mobile_frontend/model/get-reservation-response.dart';

import '../Core/utils/widgets/warning-dialogs.dart';
import '../model/login-response-model.dart';
import 'api-service-provider.dart';

class GetReservationProvider extends ChangeNotifier {
  Status _status = Status.unauthenticated;

  Status get status => _status;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  GetReservationsResponse? getReservationsResponse;

  GetReservationsResponse? get _getReservationsResponse =>
      getReservationsResponse;

  BookSlotsResponse? getBookslotsResponse;

  BookSlotsResponse? get _getbookSlotsResponse => getBookslotsResponse;

  LoginResponseModel? _loginDataModel;

  LoginResponseModel? get loginDataModel => _loginDataModel;

  List<GetReservations> getreservations = [];

  bool visible = false;

  /* Get Acess token of current user */
  void getAccessToken(BuildContext context) async {
    var email = await SharedPreference().getemail();
    var password = await SharedPreference().getPassword();
    notifyListeners();
    _isLoading = true;
    _loginDataModel =
        await Provider.of<APIServiceProvider>(context, listen: false)
            .userLoginApi(email.toString().trim(), password.toString().trim());
    if (_loginDataModel!.status != null) {
      if (_loginDataModel?.status == false) {
        warningDialogs(context, _loginDataModel!.message);
      } else {
        final bool setToken =
            await SharedPreference().setToken(_loginDataModel!.token!);
        getreservationsdata(context);
      }
    } else {
      warningDialogs(context, 'Internal Server Error, Please try again');
    }
  }

  /* Clear All slot Datas */
  clearData() {
    getreservations.clear();
    notifyListeners();
  }

  /* Get reservation List API function */
  getreservationsdata(BuildContext context) async {
    _status = Status.authenticating;
    notifyListeners();
    getreservations.clear();
    _isLoading = true;
    visible = false;
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      getReservationsResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .getReservationsAPI();
      _status = Status.authenticated;
      _isLoading = false;
      notifyListeners();
      if (getReservationsResponse?.status == false) {
        _isLoading = false;
        //  warningDialogs(context, _getReservationsResponse!.message);
      } else {
        for (int i = 0;
            i < getReservationsResponse!.getReservations!.length;
            i++) {
          GetReservations sd = GetReservations();
          sd.bookingId =
              getReservationsResponse!.getReservations![i].bookingId.toString();
          sd.outletName = getReservationsResponse!
              .getReservations![i].outletName
              .toString();
          sd.currentWaitTime = getReservationsResponse!
              .getReservations![i].currentWaitTime
              .toString();
          sd.originalBookingId = getReservationsResponse!
              .getReservations![i].originalBookingId
              .toString();
          final birthday = DateTime.parse(getReservationsResponse!
              .getReservations![i].slotdatetime
              .toString());
          final date2 = DateTime.now();
          final difference = birthday.difference(date2).inSeconds;
          int h = difference ~/ 3600;

          int m = ((difference - h * 3600)) ~/ 60;

          int s = difference - (h * 3600) - (m * 60);

          String result = (h < 0
              ? '0'
              : h.toString()) +
                  'h ' +
                  (m < 0 ? '0' : m.toString()) +
                  'm ' +
                  (s < 0 ? '0' : s.toString()) +
                  's ';

          sd.currentWaitTime = result;

          print(result);
          getreservations.add(sd);
        }
        notifyListeners();
      }
    } else {
      _isLoading = false;
      _status = Status.unauthenticated;
      warningDialogs(context, 'You are currently offline');
    }
  }

  /* Cancel reservation List API function */
  cancelreservationsdata(BuildContext context, String bookingId) async {
    _status = Status.authenticating;
    notifyListeners();
    _isLoading = true;
    // getreservations.clear();
    visible = false;
    print(bookingId);
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      getBookslotsResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .cancelReservationsAPI(bookingId);
      _status = Status.authenticated;
      _isLoading = false;
      notifyListeners();
      if (getBookslotsResponse?.status == false) {
        _isLoading = false;
        warningDialogs(context, getBookslotsResponse!.message);
      } else {
        final birthday = DateTime.parse(
            getBookslotsResponse!.booking!.slotdateTime.toString());
        final date2 = DateTime.now();
        final difference = date2.difference(birthday).inSeconds;
        int h = difference ~/ 3600;

        int m = ((difference - h * 3600)) ~/ 60;

        int s = difference - (h * 3600) - (m * 60);

        String result = (h < 0
              ? '0'
              : h.toString()) +
                  'h ' +
                  (m < 0 ? '0' : m.toString()) +
                  'm ' +
                  (s < 0 ? '0' : s.toString()) +
                  's ';
        getBookslotsResponse!.booking!.currentWaitTime = result;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SucessrestaurantbookingScreenDialog(
                    getBookslotsResponse!, 'Cancel', '')));
        notifyListeners();
      }
    } else {
      _isLoading = false;
      _status = Status.unauthenticated;
      warningDialogs(context, 'You are currently offline');
    }
  }
}
