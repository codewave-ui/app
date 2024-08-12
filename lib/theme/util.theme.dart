import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(BuildContext context, Brightness brightness,
    String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);

  if (brightness == Brightness.light) {
    return displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      bodyMedium:
          bodyTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      bodySmall: bodyTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      labelLarge:
          bodyTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      labelMedium:
          bodyTextTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
      labelSmall:
          bodyTextTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
      displayLarge:
          bodyTextTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
      displayMedium:
          bodyTextTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
      displaySmall:
          bodyTextTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
      headlineLarge:
          bodyTextTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
      headlineMedium:
          bodyTextTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
      titleLarge:
          bodyTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      headlineSmall:
          bodyTextTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      titleMedium:
          bodyTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      titleSmall:
          bodyTextTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
