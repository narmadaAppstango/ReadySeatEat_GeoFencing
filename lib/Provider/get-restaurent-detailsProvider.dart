import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/constants/string-constants.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/color_constant.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/api-service-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/shared-preference.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/present-reservation-screen.dart';
import 'package:restaurent_seating_mobile_frontend/model/login-response-model.dart';
import 'package:restaurent_seating_mobile_frontend/model/outlet-search-response.dart';
import 'package:restaurent_seating_mobile_frontend/model/outlet-details-model.dart';

class GetRestaurentDetailsProvider extends ChangeNotifier {
  Status _status = Status.unauthenticated;

  Status get status => _status;

  TextEditingController? _restaurentName = TextEditingController();

  TextEditingController? get restaurentName => _restaurentName;

  TextEditingController? _address = TextEditingController();

  TextEditingController? get address => _address;

  TextEditingController? _phoneNo = TextEditingController();

  TextEditingController? get phoneNo => _phoneNo;

  List<String> _image = [];
  List<String> get image => _image;

  var _profileImage = "";
  String get profileImage => _profileImage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String outletid = '';

  OutletDetailsResponse? _outletdetailsResponseDataModel;

  OutletDetailsResponse? get outletdetailsresponseModel =>
      _outletdetailsResponseDataModel;

  OutLetSearchResponse? _outletSearchResponse;
  OutLetSearchResponse? get outletSearchResponse => _outletSearchResponse;

  LoginResponseModel? _loginDataModel;

  LoginResponseModel? get loginDataModel => _loginDataModel;

  List<OutletsNames> value = [];
  List<OutletsNames> outletNames = [];

  String? currentText = "";

  String? get curentText => curentText;

  /* Get Acess token of current user */
  void getAccessToken(BuildContext context, mode, mode2) async {
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
        if (mode2 == 'ResDet') {
          getRestaurentdetails(context, mode);
        } else {
          getRestaurents(context);
        }
      }
    } else {
      warningDialogs(context, 'Internal Server Error, Please try again');
    }
  }

  /* Get Restaurant details calling API calling function */
  getRestaurentdetails(BuildContext context, String mode) async {
    _status = Status.authenticating;
    _isLoading = true;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _outletdetailsResponseDataModel =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .getRestaurentDetailsApi(mode);
      _status = Status.authenticated;
      _isLoading = false;
      notifyListeners();
      if (_outletdetailsResponseDataModel?.status == false) {
        warningDialog(context, _outletdetailsResponseDataModel!.message);
      } else {
        setValueFromResponse(_outletdetailsResponseDataModel!);
      }
    } else {
      _status = Status.unauthenticated;
      warningDialog(context, 'You are currently offline');
    }
  }

  /* Warning Dialog */
  warningDialog(BuildContext context, msg) {
    Dialogs.materialDialog(
        color: Colors.white,
        msg: msg,
        title: appName,
        barrierDismissible: false,
        msgStyle: TextStyle(
            color: ColorConstant.black900,
            wordSpacing: 1.3,
            fontSize: 14,
            letterSpacing: 0.3,
            fontWeight: FontWeight.w500,
            fontFamily: 'OpenSansSemiBold'),
        context: context,
        lottieBuilder: LottieBuilder.asset(
          "assets/alert.json",
          repeat: true,
          width: 100,
          height: 100,
        ),
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PresentReservationScreen()));
            },
            text: ok,
            //iconData: Icons.ok,
            color: ColorConstant.amberA700,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  /* Get Restaurants List API function */
  getRestaurents(BuildContext context) async {
    _status = Status.authenticating;
    notifyListeners();
    var netStatus = await SharedPreference().getinternetstatus();
    if (netStatus.toString() != '') {
      _outletSearchResponse =
          await Provider.of<APIServiceProvider>(context, listen: false)
              .getRestaurentsApi();
      _status = Status.authenticated;
      notifyListeners();
      if (_outletSearchResponse?.status == false) {
        _isLoading = false;
      } else {
        outletNames.clear();
        value = _outletSearchResponse!.outletsNames!
            .map((nameJson) => OutletsNames.fromJson(nameJson.toJson()))
            .toList();
        outletNames.addAll(value);
        notifyListeners();
      }
    } else {
      _isLoading = false;
      _status = Status.unauthenticated;
      warningDialog(context, 'You are currently offline');
    }
  }

  /* Clear Data */
  clearData() {
    _image.clear();
    _phoneNo!.clear();
    _address!.clear();
    _restaurentName!.clear();
    _isLoading = false;
    notifyListeners();
  }

  /* Set Value from response */
  void setValueFromResponse(OutletDetailsResponse? data) {
    outletid = data!.outlets!.outletid ?? "";
    _phoneNo!.text = (data.outlets!.phoneNumber ?? "");
    _address!.text = (data.outlets!.address ?? "");
    _restaurentName!.text = (data.outlets!.name ?? "");
    _image = (data.outlets!.images ?? []);
    _isLoading = false;
    notifyListeners();
  }
}
