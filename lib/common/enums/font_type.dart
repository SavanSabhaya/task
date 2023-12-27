import 'dart:ui';

enum FFT { clover, plusJakartaSans }

enum FWT { regular, medium, semiBold, bold, extraBold }

class FontType {
  static getFontFamilyType(FFT? fontFamilyType) {
    switch (fontFamilyType) {
      case FFT.clover:
        return "Clover Display";
      case FFT.plusJakartaSans:
        return "Plus Jakarta Sans";
      default:
        return "Clover Display";
    }
  }

  static FontWeight getFontWeightType(FWT? fontWeightType) {
    switch (fontWeightType) {
      case FWT.regular:
        return FontWeight.w400;
      case FWT.medium:
        return FontWeight.w500;
      case FWT.semiBold:
        return FontWeight.w600;
      case FWT.bold:
        return FontWeight.w700;
      case FWT.extraBold:
        return FontWeight.w800;
      default:
        return FontWeight.normal;
    }
  }
}
