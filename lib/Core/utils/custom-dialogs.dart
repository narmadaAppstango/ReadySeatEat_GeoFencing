import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/app_export.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/common-imageView.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/create-profile-provider.dart';

class FullScreenDialog extends StatefulWidget {
  const FullScreenDialog({Key? key}) : super(key: key);

  @override
  _FullScreenDialogState createState() => _FullScreenDialogState();
}

class _FullScreenDialogState extends State<FullScreenDialog> {
  // String

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateProfileProvider>(builder: (context, object, child) {
      return Scaffold(
        backgroundColor: ColorConstant.black900,
        body: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          margin: EdgeInsets.only(left: 20, right: 20, top: 130, bottom: 83),
          padding: EdgeInsets.all(15.0),
          color: ColorConstant.whiteA700,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: getSize(120.00),
                  width: getSize(120.00),
                  margin: getMargin(left: 32, top: 33, right: 32, bottom: 20),
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      color: ColorConstant.amberA700,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(getHorizontalSize(60.00))),
                      child: Stack(children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding:
                                    getPadding(left: 10, top: 10, right: 9),
                                child: CommonImageView(
                                    svgPath: 'assets/images/person.svg',
                                    height: getVerticalSize(104.00),
                                    width: getHorizontalSize(100.00))))
                      ]))),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Are You Sure You Want to Delete Your Account ?',
                    textAlign: TextAlign.center,
                    style: AppStyle.textstylerobotoromansemibold18
                        .copyWith(fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'WARNING',
                    style: AppStyle.textstylerobotoromansemibold18
                        .copyWith(fontSize: 20, color: ColorConstant.red600),
                  )),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'All Data Will be Deleted\n' + 'Permanently',
                    textAlign: TextAlign.center,
                    style: AppStyle.textstylerobotoromanregular13
                        .copyWith(fontSize: 18),
                  )),
              object.isload == true
                  ? Center(
                      child: SizedBox(
                        child: Lottie.asset("assets/loading-rs.json"),
                        width: 100,
                        height: 100,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          object.isload = true;
                          object.deleteAccountFunction(context);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(
                            39.00,
                          ),
                          top: getVerticalSize(
                            20.00,
                          ),
                          right: getHorizontalSize(
                            39.00,
                          ),
                          bottom: getVerticalSize(
                            10.00,
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
                          decoration: BoxDecoration(
                            color: ColorConstant.amberA700,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                5.00,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstant.amberA700,
                              ),
                            ],
                          ),
                          child: Text(
                            'Yes'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: AppStyle.textstylerobotoromansemibold16
                                .copyWith(
                              color: ColorConstant.black900,
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
                  Navigator.pop(context);
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
                      right: getHorizontalSize(
                        39.00,
                      ),
                      bottom: getVerticalSize(
                        10.00,
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
                      decoration: BoxDecoration(
                        color: ColorConstant.black900,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            5.00,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstant.black90040,
                          ),
                        ],
                      ),
                      child: Text(
                        "No".toUpperCase(),
                        textAlign: TextAlign.left,
                        style:
                            AppStyle.textstylerobotoromansemibold166.copyWith(
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
      );
    });
  }
}
