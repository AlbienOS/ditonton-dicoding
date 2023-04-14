import 'package:flutter/material.dart';

// colors
const Color kRichBlack = Color(0xFF000814);
const Color kOxfordBlue = Color(0xFF001D3D);
const Color kPrussianBlue = Color(0xFF003566);
const Color kMikadoYellow = Color(0xFFffc300);
const Color kDavysGrey = Color(0xFF4B5358);
const Color kGrey = Color(0xFF303030);
final Color kGrey70 = kGrey.withAlpha(255 - (255 * 0.7).ceil());
final Color kGrey30 = kGrey.withAlpha(255 - (255 * 0.3).ceil());

const kColorScheme = ColorScheme(
  primary: kMikadoYellow,
  primaryVariant: kMikadoYellow,
  secondary: kPrussianBlue,
  secondaryVariant: kPrussianBlue,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.red,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
