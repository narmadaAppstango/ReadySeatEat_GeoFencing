import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/api-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/model/SocialLoginResponseModel.dart';
import 'package:restaurent_seating_mobile_frontend/model/book-slot-response.dart';
import 'package:restaurent_seating_mobile_frontend/model/common-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/email-verification-data-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/forget-password-responsemodel.dart';
import 'package:restaurent_seating_mobile_frontend/model/get-previous-reservationresponse.dart';
import 'package:restaurent_seating_mobile_frontend/model/get-reservation-response.dart';
import 'package:restaurent_seating_mobile_frontend/model/login-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/resend-verificationsignup-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/reset-password-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/outlet-search-response.dart';
import 'package:restaurent_seating_mobile_frontend/model/outlet-details-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/signup-response-model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:intl/intl.dart';
import 'package:restaurent_seating_mobile_frontend/model/slotreservationResponse.dart';

import '../model/token-response-model.dart';

class APIServiceProvider extends ChangeNotifier {
  Status _status = Status.unauthenticated;

  Status get status => _status;

  final Dio _httpClient = Dio();

  Dio get httpClient => _httpClient;

  /*  Send push notifications Api */
  Future<TokenResponse> sendPushNotifiApi(userid) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();

    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {"user_id": userid, "booking_id": "booking_96rvy"};
    return await http
        .post(Uri.parse(sendPushNoticationAPI),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      print(sendPushNoticationAPI);
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        print(res.body.toString());
        return tokenResponseFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return TokenResponse();
      }
    });
  }

  /*  Send Device token Api */
  Future<TokenResponse> sendDeviceTokenApi(
      userid, devicetoken, devicetype) async {
    print('TOKEN receiveing ' + devicetoken + '    ' + userid);
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();

    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {
      "user_id": userid,
      "device_token": devicetoken,
      "device_type":'android',
      "enable_push_noti": "1"
    };
    return await http
        .post(Uri.parse(storeappuserdevicetokenapi),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      print(storeappuserdevicetokenapi);
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        print(res.body);
        return tokenResponseFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return TokenResponse();
      }
    });
  }

  /*  Sign Up Api */

  Future<SignupResponseModel?> userCreateApi(email, password) async {
    _status = Status.authenticating;

    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var param = {
      "email": email,
      "password": password,
    };
    return await http
        .post(Uri.parse(signupAPI),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        notifyListeners();
        return signupResponseModelFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return SignupResponseModel();
      }
    });
  }

/*   Delete Account Api */
  Future<CommonResponseDataModel?> deleteaccountapi(userId) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {
      "user_id": userId,
    };
    return await http
        .post(Uri.parse(deleteAccountApi),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        notifyListeners();
        return commonResponseDataModelFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return CommonResponseDataModel();
      }
    });
  }

/*  Resend Code Api */
  Future<ResendSignupCodeResponse?> resendCodeApi(String emailText) async {
    _status = Status.authenticating;
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var param = {
      'email': emailText,
    };
    return await http
        .post(Uri.parse(resendOTpSignupApi),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        return resendSignupCodeResponseFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return ResendSignupCodeResponse();
      }
    });
  }

/*  Login Api */
  Future<LoginResponseModel> userLoginApi(email, password) async {
    _status = Status.authenticating;
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var param = {
      'email': email,
      'password': password,
    };
    return await http
        .post(Uri.parse(signAPI),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        return loginModelResponseFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return LoginResponseModel();
      }
    });
  }

  /*    Social Login API   */
  Future<SocialLoginResponse?> socialLoginapi(email, socName, userId) async {
    _status = Status.authenticating;
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var param = {
      "cognito_user_id": userId,
      "login_from": socName,
      "user_email": email
    };
    return await http
        .post(Uri.parse(socialLoginApi),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        return socialLoginResponseFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return SocialLoginResponse();
      }
    });
  }

/*  Forget Password API */
  Future<ForgetPasswordResponseModel?> forgetPasswordApi(email) async {
    _status = Status.authenticating;
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var param = {
      'email': email,
    };
    return await http
        .post(Uri.parse(forgetPasswordAPI),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        return forgetPasswordResponseModelFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return ForgetPasswordResponseModel();
      }
    });
  }

/*   Email Verification API  */
  Future<EmailVerificationResponseModel?> emailVerificationApi(
      otp, String emailText) async {
    _status = Status.authenticating;
    notifyListeners();

    var param = {
      "email": emailText,
      "confirm-otp": otp,
    };
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    return await http
        .post(Uri.parse(emailVerificationAPI),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        return emailVerificationResponseModelFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return EmailVerificationResponseModel();
      }
    });
  }

/*   Confirm Forget Password API   */
  Future<ResetPasswordResponseDataModel?> confirmForgetPasswordApi(
      otp, password, email) async {
    _status = Status.authenticating;
    notifyListeners();

    var param = {
      "email": email,
      "password": password,
      "confirmation_code": otp
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    return await http
        .post(Uri.parse(confirmForgetPasswordAPI),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        return resetPasswordResponseDataModelFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return ResetPasswordResponseDataModel();
      }
    });
  }

/*     Change Password API    */
  Future<ResetPasswordResponseDataModel?> changePasswordApi(
      oldpassword, newpassword) async {
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    _status = Status.authenticating;
    notifyListeners();

    var param = {
      "user_id": id.toString(),
      "old_password": oldpassword,
      "new_password": newpassword
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    return await http
        .post(Uri.parse(changePasswordAPI),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      _status = Status.authenticated;
      if (res.statusCode == 200) {
        return resetPasswordResponseDataModelFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return ResetPasswordResponseDataModel();
      }
    });
  }

  /*   Create & Update User Profile API  */
  Future<CommonResponseDataModel?> createUserProfileApi(
      fname, mname, lname, phonenumber, File image, emailid, mode) async {
    _status = Status.authenticating;
    var userid = await SharedPreference().getUserId();
    var token = await SharedPreference().getToken();
    final dir = await path_provider.getTemporaryDirectory();
    DateTime d = DateTime.now();
    final f = new DateFormat('dd-MM-yyyyhh-mm-ss');
    File? imageFile;
    if (image.isAbsolute) {
      final targetPath =
          dir.absolute.path + "/profile" + f.format(d).toString() + ".jpg";
      String fileName = image.path.split('/').last;
      imageFile = await compressProfileImage(image, targetPath, fileName);
    }
    var formData = FormData.fromMap({
      "id": userid.toString().trim(),
      "first_name": fname.toString().trim(),
      "middle_name": mname.toString().trim(),
      "last_name": lname.toString().trim(),
      "phone_number": phonenumber.toString().trim(),
      "profile_pic": image.isAbsolute
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: imageFile.path.split('/').last)
          : '',
      "is_pic_update": image.isAbsolute ? '1' : '0',
    });
    Options options = Options(
      headers: {
        'Content-type':
            'multipart/form-data; boundary=<calculated when request is sent>',
        'Accept': '*/*',
        "token": token.toString()
      },
      followRedirects: false,
      // will not throw errors
      validateStatus: (status) => true,
    );
    _status = Status.authenticated;
    notifyListeners();
    final res = await httpClient.post(createUserProfileAPI.toString().trim(),
        data: formData, options: options);
    if (res.statusCode == 200) {
      return CommonResponseDataModel.fromJson(res.data);
    } else {
      _status = Status.unauthenticated;
      return CommonResponseDataModel();
    }
  }

/* CompressProfile Image function */
  Future<File> compressProfileImage(
      File newFile, String targetPath, String fileName) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      newFile.absolute.path,
      targetPath,
      quality: 60,
      minWidth: 512,
      minHeight: 512,
      rotate: 0,
    );

    return result!;
  }

  /* Get Restaurent Details API */
  Future<OutletDetailsResponse?> getRestaurentDetailsApi(restaurentid) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    var param = {"user_id": id.toString(), "outlet_id": restaurentid};
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };

    return await http
        .post(Uri.parse(getRestaurentDetailsAPI),
            headers: requestHeaders, body: jsonEncode(param))
        .then((res) {
      if (res.statusCode == 200) {
        _status = Status.authenticated;
        return outletDetailsResponseFromJson(res.body);
      } else {
        _status = Status.unauthenticated;
        return OutletDetailsResponse();
      }
    });
  }

  /* Get Restaurant Name API */

  Future<OutLetSearchResponse?> getRestaurentsApi() async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {
      "user_id": id.toString(),
    };
    var res = await http.post(Uri.parse(getRestaurantsAPI),
        headers: requestHeaders, body: jsonEncode(param));
    print(getRestaurantsAPI);
    print(res.body.toString());
    if (res.statusCode == 200) {
      _status = Status.authenticated;
      return outletSearchResponseFromJson(res.body);
    } else {
      _status = Status.unauthenticated;
      return OutLetSearchResponse();
    }
  }

  /* Get Slot Details API */
  Future<SlotReservationResponse?> getSlotDetailsAPI(
      outletid, startdate, starttime, noofseats) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    DateTime dd = DateFormat('dd MMM, yyyy').parse(startdate);
    String date1 = DateFormat('yyyy-MM-dd').format(dd).toString();
    print(date1);
    var param = {
      "user_id": id.toString(),
      "outlet_id": outletid,
      "start_date": date1,
      "end_date": date1,
      "slot_time": starttime,
      "no_of_seats": noofseats,
    };
    var res = await http.post(Uri.parse(getSlotdetailsApi),
        headers: requestHeaders, body: jsonEncode(param));
    print(getSlotdetailsApi);
    print(param.toString());
    print(res.body.toString());
    if (res.statusCode == 200) {
      _status = Status.authenticated;
      return slotReservationResponseFromJson(res.body);
    } else {
      _status = Status.unauthenticated;
      return SlotReservationResponse();
    }
  }

  /* Slot Booking API */
  Future<BookSlotsResponse?> bookSlotsAPi(outletid, slotid) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {
      "outlet_id": outletid,
      "slot_id": slotid,
      "user_id": id.toString(),
    };
    var res = await http.post(Uri.parse(slotBookingAPI),
        headers: requestHeaders, body: jsonEncode(param));
    print(slotBookingAPI);
    print(param.toString());
    print(res.body.toString());
    if (res.statusCode == 200) {
      _status = Status.authenticated;
      return bookSlotsResponseFromJson(res.body);
    } else {
      _status = Status.unauthenticated;
      return BookSlotsResponse();
    }
  }

  /* Update Slot Booking API */
  Future<BookSlotsResponse?> updateSlotsAPi(outletid, slotid, bookingid) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {
      "user_id": id.toString(),
      "booking_id": bookingid,
      "outlet_id": outletid,
      "slot_id": slotid,
    };
    var res = await http.post(Uri.parse(updatereservationsApi),
        headers: requestHeaders, body: jsonEncode(param));
    print(updatereservationsApi);
    print(param.toString());
    print(res.body.toString());
    if (res.statusCode == 200) {
      _status = Status.authenticated;
      return bookSlotsResponseFromJson(res.body);
    } else {
      _status = Status.unauthenticated;
      return BookSlotsResponse();
    }
  }

  /* Get all Reservations details API */
  Future<GetReservationsResponse?> getReservationsAPI() async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {
      "user_id": id.toString(),
    };
    var res = await http.post(Uri.parse(getreservationsApi),
        headers: requestHeaders, body: jsonEncode(param));
    print(getreservationsApi);
    print(param.toString());
    print(res.body.toString());
    if (res.statusCode == 200) {
      _status = Status.authenticated;
      return getReservationsResponseFromJson(res.body);
    } else {
      _status = Status.unauthenticated;
      return GetReservationsResponse();
    }
  }

  /* Get Previous Reservations details API */
  Future<GetPreviousReservationsResponse?> getPreviousReservationsApi(
      bookingId) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {
      "user_id": id.toString(),
      "booking_id": bookingId.toString(),
    };
    var res = await http.post(Uri.parse(previousReservationsAPI),
        headers: requestHeaders, body: jsonEncode(param));
    print(previousReservationsAPI);
    print(param.toString());
    print(res.body.toString());
    if (res.statusCode == 200) {
      _status = Status.authenticated;
      return getPreviousReservationsResponseFromJson(res.body);
    } else {
      _status = Status.unauthenticated;
      return GetPreviousReservationsResponse();
    }
  }

  /* Cancel all Reservations details API */
  Future<BookSlotsResponse?> cancelReservationsAPI(String bookingId) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {
      "user_id": id.toString(),
      "booking_id": bookingId.toString().trim()
    };
    var res = await http.post(Uri.parse(cancelreservationsApi),
        headers: requestHeaders, body: jsonEncode(param));
    print(cancelreservationsApi);
    print(param.toString());
    print(res.body.toString());
    if (res.statusCode == 200) {
      _status = Status.authenticated;
      return bookSlotsResponseFromJson(res.body);
    } else {
      _status = Status.unauthenticated;
      return BookSlotsResponse();
    }
  }

  /* verify user reservations details API */
  Future<CommonResponseDataModel?> verifyUserReservationAPI(bookingId) async {
    _status = Status.authenticating;
    var token = await SharedPreference().getToken();
    var id = await SharedPreference().getUserId();
    notifyListeners();
    Map<String, String> requestHeaders = {
      "Content-type": 'application/json',
      "Accept": '*/*',
      "token": token.toString()
    };
    var param = {"user_id": id.toString(), "booking_id": bookingId};
    var res = await http.post(Uri.parse(verifyuser),
        headers: requestHeaders, body: jsonEncode(param));
    print(verifyuser);
    print(param.toString());
    print(res.body.toString());
    if (res.statusCode == 200) {
      _status = Status.authenticated;
      return commonResponseDataModelFromJson(res.body);
    } else {
      _status = Status.unauthenticated;
      return CommonResponseDataModel();
    }
  }
}
