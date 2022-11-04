import 'package:flutter/material.dart';
import 'package:restaurent_seating_mobile_frontend/core/app_export.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.onTap,
      this.width,
      this.margin,
      this.text});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  VoidCallback? onTap;

  double? width;

  EdgeInsetsGeometry? margin;

  String? text;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: getHorizontalSize(width ?? 0),
        margin: margin,
        padding: _setPadding(),
        decoration: _buildDecoration(),
        child: Text(
          text ?? "",
          textAlign: TextAlign.center,
          style: _setFontStyle(),
        ),
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll6:
        return getPadding(
          all: 6,
        );
      case ButtonPadding.PaddingAll17:
        return getPadding(
          all: 17,
        );
      case ButtonPadding.PaddingAll13:
        return getPadding(
          all: 13,
        );
      default:
        return getPadding(
          all: 22,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillGray902:
        return ColorConstant.gray902;
      case ButtonVariant.OutlineBlack9003f1_2:
        return ColorConstant.amberA700;
      case ButtonVariant.FillAmberA700:
        return ColorConstant.amberA700;
      case ButtonVariant.OutlineBlack901:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillGray200:
        return ColorConstant.gray100;
      case ButtonVariant.FillGray201:
        return ColorConstant.gray100;
      default:
        return ColorConstant.amberA700;
    }
  }

  _setBorder() {
    switch (variant) {
      case ButtonVariant.OutlineBlack901:
        return Border.all(
          color: ColorConstant.black900,
          width: getHorizontalSize(
            2.00,
          ),
        );
      case ButtonVariant.OutlineBlack9003f:
      case ButtonVariant.FillGray902:
      case ButtonVariant.OutlineBlack9003f1_2:
      case ButtonVariant.FillAmberA700:
      case ButtonVariant.FillGray200:
      case ButtonVariant.FillGray201:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder6:
        return BorderRadius.circular(
          getHorizontalSize(
            6.00,
          ),
        );
      case ButtonShape.CustomBorderTL15:
        return BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              15.00,
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
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            30.00,
          ),
        );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case ButtonVariant.OutlineBlack9003f1_2:
        return [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              4,
            ),
          )
        ];
      case ButtonVariant.FillGray902:
      case ButtonVariant.FillAmberA700:
      case ButtonVariant.OutlineBlack901:
      case ButtonVariant.FillGray200:
      case ButtonVariant.FillGray201:
        return null;
      default:
        return [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              4,
            ),
          )
        ];
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.RobotoRomanBold10:
        return TextStyle(
          color: ColorConstant.amberA700,
          fontSize: getFontSize(
            10,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.RobotoRomanSemiBold16AmberA700:
        return TextStyle(
          color: ColorConstant.amberA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.PoppinsSemiBold16:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.PoppinsSemiBold16AmberA700:
        return TextStyle(
          color: ColorConstant.amberA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.RobotoRomanSemiBold14:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.RobotoRomanSemiBold14Gray600:
        return TextStyle(
          color: ColorConstant.gray500,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.RobotoRomanSemiBold16WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.RobotoRomanSemiBold16Gray9006c:
        return TextStyle(
          color: ColorConstant.gray500,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        );
      default:
        return TextStyle(
          color: ColorConstant.gray902,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        );
    }
  }
}

enum ButtonShape {
  Square,
  CircleBorder30,
  RoundedBorder6,
  CustomBorderTL15,
}

enum ButtonPadding {
  PaddingAll22,
  PaddingAll6,
  PaddingAll17,
  PaddingAll13,
}

enum ButtonVariant {
  OutlineBlack9003f,
  FillGray902,
  OutlineBlack9003f1_2,
  FillAmberA700,
  OutlineBlack901,
  FillGray200,
  FillGray201,
}

enum ButtonFontStyle {
  RobotoRomanSemiBold16,
  RobotoRomanBold10,
  RobotoRomanSemiBold16AmberA700,
  PoppinsSemiBold16,
  PoppinsSemiBold16AmberA700,
  RobotoRomanSemiBold14,
  RobotoRomanSemiBold14Gray600,
  RobotoRomanSemiBold16WhiteA700,
  RobotoRomanSemiBold16Gray9006c,
}
