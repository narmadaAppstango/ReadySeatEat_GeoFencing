import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color red600 = fromHex('#e33c3c');

  static Color green400 = fromHex('#42d778');

  static Color gray700 = fromHex('#636363');

  static Color gray400 = fromHex('#b3b3b3');

  static Color gray401 = fromHex('#c4c4cc');

  static Color black900E5 = fromHex('#e5000000');

  static Color black9003f = fromHex('#3f000000');

  static Color gray500 = fromHex('#969696');

  static Color gray901 = fromHex('#141414');

  static Color gray902 = fromHex('#1a1a1a');

  static Color gray800 = fromHex('#4d4d4d');

  static Color gray900 = fromHex('#241a0a');

  static Color bluegray100 = fromHex('#d4d4d4');

  static Color gray50 = fromHex('#fcfcfc');

  static Color gray100 = fromHex('#f5f5fa');

  static Color red100 = fromHex('#e8d1cf');

  static Color bluegray900 = fromHex('#2e2e2e');

  static Color amberA700 = fromHex('#ffab00');

  static Color amberdisabled = fromHex('#FFEECC');

  static Color blackdisabled = fromHex('#D2C4A9');

  static Color black900 = fromHex('#000000');

  static Color bluegray400 = fromHex('#888888');

  static Color black90040 = fromHex('#40000000');

  static Color whiteA701 = fromHex('#fffffc');

  static Color whiteA700 = fromHex('#ffffff');

  static Color yellow100 = fromHex('#fff0cc');

  static Color amberlight = fromHex('#E8CC95');

  static Color amberd = fromHex('#FFEFCD');

  Color grey = const Color(0xFF9F99A8);
  Color blue = const Color(0xFF3796DB);
  Color white = const Color(0xFFFFFFFF);
  Color red = const Color(0xFFF43E45);
  Color yellow = const Color(0xFFFFC700);
  Color green = Color(0xFF03ca65);

//bright purple to green
  MaterialColor greenColor = const MaterialColor(
    0xFF03CA65,
    <int, Color>{
      50: Color(0xFFe6faf0),
      100: Color(0xFFcdf4e0),
      200: Color(0xFFb3efd1),
      300: Color(0xFF9aeac1),
      400: Color(0xFF81e5b2),
      500: Color(0xFF68dfa3),
      600: Color(0xFF4fda93),
      700: Color(0xFF35d584),
      800: Color(0xFF1ccf74),
      900: Color(0xFF03ca65),
    },
  );

// const MaterialColor brightPurple = MaterialColor(
//   0xFF02BBFE,
//   <int, Color>{
//     50: Color(0xFFe6f8ff),
//     100: Color(0xFFccf1ff),
//     200: Color(0xFFb3ebff),
//     300: Color(0xFF9ae4ff),
//     400: Color(0xFF81ddff),
//     500: Color(0xFF67d6fe),
//     600: Color(0xFF4ecffe),
//     700: Color(0xFF35c9fe),
//     800: Color(0xFF1bc2fe),
//     900: Color(0xFF02bbfe),
//   },
// );

/*dark purple to logo blue*/
  MaterialColor logoBlueColor = const MaterialColor(
    0xFF02bbfe,
    <int, Color>{
      50: Color(0xFFe6f8ff),
      100: Color(0xFFccf1ff),
      200: Color(0xFFb3ebff),
      300: Color(0xFF9ae4ff),
      400: Color(0xFF81ddff),
      500: Color(0xFF67d6fe),
      600: Color(0xFF4ecffe),
      700: Color(0xFF35c9fe),
      800: Color(0xFF1bc2fe),
      900: Color(0xFF02bbfe),
    },
  );

//cream purple to cream blue
  MaterialColor creamBlue = const MaterialColor(
    0xFFFDFDFD,
    <int, Color>{
      50: Color(0xFFffffff),
      100: Color(0xFFffffff),
      200: Color(0xFFffffff),
      300: Color(0xFFfefefe),
      400: Color(0xFFfefefe),
      500: Color(0xFFfefefe),
      600: Color(0xFFfefefe),
      700: Color(0xFFfdfdfd),
      800: Color(0xFFfdfdfd),
      900: Color(0xFFFDFDFD),
    },
  );

  MaterialColor redColor = const MaterialColor(
    0xFFf43e45,
    <int, Color>{
      50: Color(0xFFfeecec),
      100: Color(0xFFfdd8da),
      200: Color(0xFFfcc5c7),
      300: Color(0xFFfbb2b5),
      400: Color(0xFFfa9fa2),
      500: Color(0xFFf88b8f),
      600: Color(0xFFf7787d),
      700: Color(0xFFf6656a),
      800: Color(0xFFf55158),
      900: Color(0xFFf43e45),
    },
  );

  MaterialColor yellowColor = const MaterialColor(
    0xFFFFD700,
    <int, Color>{
      50: Color(0xFFfffbe6),
      100: Color(0xFFfff7cc),
      200: Color(0xFFfff3b3),
      300: Color(0xFFffef99),
      400: Color(0xFFffeb80),
      500: Color(0xFFffe766),
      600: Color(0xFFffe34d),
      700: Color(0xFFffdf33),
      800: Color(0xFFffdb1a),
      900: Color(0xFFffd700),
    },
  );

  MaterialColor whiteColor = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFffffff),
      100: Color(0xFFffffff),
      200: Color(0xFFffffff),
      300: Color(0xFFffffff),
      400: Color(0xFFffffff),
      500: Color(0xFFffffff),
      600: Color(0xFFffffff),
      700: Color(0xFFffffff),
      800: Color(0xFFffffff),
      900: Color(0xFFffffff),
    },
  );

  MaterialColor blackColor = const MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFFe6e6e6),
      100: Color(0xFFcccccc),
      200: Color(0xFFb3b3b3),
      300: Color(0xFF999999),
      400: Color(0xFF808080),
      500: Color(0xFF666666),
      600: Color(0xFF4d4d4d),
      700: Color(0xFF333333),
      800: Color(0xFF1a1a1a),
      900: Color(0xFF000000),
    },
  );

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
