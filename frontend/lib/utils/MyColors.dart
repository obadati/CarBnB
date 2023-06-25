import 'package:flutter/material.dart';

Color gradientEndColor = Color(0xFFe7d8c3);
Color backgroundColor = Color(0xFF39A9A);
Color gradientStartColor = Color(0xFFede9de);
Color statusBarColor = Color(0xFF0a8db4);
Color selectedTabBgColor = Color(0xFFCB2E2F);
Color unSelectedTabBgColor = Color(0xFF86D2E8);

Color themeRedColor = HexColor.fromHex('#e12a2b');
Color disableRedColor = HexColor.fromHex('#fbcdcf');
Color themeGreenColor = HexColor.fromHex('#00ff02'); //

LinearGradient gradientBackgroundColor = LinearGradient(
  colors: [gradientStartColor, gradientEndColor],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
