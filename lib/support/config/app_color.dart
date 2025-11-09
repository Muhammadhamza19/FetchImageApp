import 'package:flutter/material.dart';

/// main app color
MaterialColor primaryColor = createMaterialColor(
  _primaryColor,
);

/// secondary app color
MaterialColor secondaryColor = createMaterialColor(
  _secondaryColor,
);

/// background color
Color backgroundColor = _backgroundColor;

/// other colors
MaterialColor redColor = createMaterialColor(
  const Color(
    0xFFF36565,
  ),
);
MaterialColor greenColor = createMaterialColor(
  const Color(
    0xFF56CE0A,
  ),
);
MaterialColor highlightColor = createMaterialColor(
  const Color(
    0xFFE8F5E9,
  ),
);

MaterialColor textFieldBorderColor = createMaterialColor(
  const Color(
    0xFFE0E0E0,
  ),
);
MaterialColor textFieldColor = createMaterialColor(
  const Color(
    0xFFF8F8F8,
  ),
);

MaterialColor disabledColor = createMaterialColor(
  const Color(
    0xFFF3F4F6,
  ),
);

MaterialColor dividerColor = createMaterialColor(
  const Color(
    0xFFE5E7EB,
  ),
);

MaterialColor disabledTextColor = createMaterialColor(
  const Color(
    0xFF4B5563,
  ),
);

MaterialColor blackColor = createMaterialColor(
  const Color(
    0xFF2A2A2A,
  ),
);

MaterialColor get whiteColor => createMaterialColor(
      const Color(
        0xFFFFFFFF,
      ),
    );
MaterialColor get secondaryColor_1 => createMaterialColor(
      const Color(
        0xFF878A99,
      ),
    );
MaterialColor get borderColor => createMaterialColor(
      const Color(
        0xFFCBD5E1,
      ),
    );
MaterialColor yellowColor = createMaterialColor(
  const Color(
    0xFFF59E0B,
  ),
);

/// primary color by flavor
Color get _primaryColor {
  switch (const String.fromEnvironment('FLUTTER_APP_FLAVOR')) {
    case "dev":
      return const Color(
        0xFF2E7D32,
      );
    case "prod":
      return const Color(
        0xFF2E7D32,
      );

    default:
      return const Color(
        0xFF2E7D32,
      );
  }
}

/// secondary color by flavor
Color get _secondaryColor {
  const flavor =
      String.fromEnvironment('FLUTTER_APP_FLAVOR', defaultValue: 'unknown');
  switch (flavor) {
    case "dev":
      return const Color(0xFF0F1114);

    default:
      return const Color(0xFF0F1114);
  }
}

/// background color by flavor
Color get _backgroundColor {
  const flavor =
      String.fromEnvironment('FLUTTER_APP_FLAVOR', defaultValue: 'unknown');
  switch (flavor) {
    case "dev":
      return const Color(
        0xFFf7f7f7,
      );

    default:
      return const Color(
        0xFFf7f7f7,
      );
  }
}

/// material color generator
MaterialColor createMaterialColor(Color color) {
  final List strengths = <double>[.05];
  final Map<int, Color> swatch = {};
  final int r = (color.r * 255.0).round() & 0xff,
      g = (color.g * 255.0).round() & 0xff,
      b = (color.b * 255.0).round() & 0xff;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
