import 'package:flutter/material.dart';

enum TTTravels { light, regular, bold }

enum Suprapower { light, regular, bold }

extension TTTravelsExt on TTTravels {
  String get familyName => 'TTTravels';

  FontWeight get weight {
    switch (this) {
      case TTTravels.light:
        return FontWeight.w200;
      case TTTravels.regular:
        return FontWeight.w400;
      case TTTravels.bold:
        return FontWeight.w700;
    }
  }
}

extension SuprapowerExt on Suprapower {
  String get familyName => 'Suprapower';

  FontWeight get weight {
    switch (this) {
      case Suprapower.light:
        return FontWeight.w200;
      case Suprapower.regular:
        return FontWeight.w400;
      case Suprapower.bold:
        return FontWeight.w900;
    }
  }
}
