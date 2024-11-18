import "package:flutter/material.dart";

class MaterialTheme {
  const MaterialTheme(this.textTheme);
  final TextTheme textTheme;

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff2b6a46),
      surfaceTint: Color(0xff2b6a46),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffaff1c4),
      onPrimaryContainer: Color(0xff002110),
      secondary: Color(0xff4f6354),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd1e8d5),
      onSecondaryContainer: Color(0xff0c1f14),
      tertiary: Color(0xff3b6470),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbee9f7),
      onTertiaryContainer: Color(0xff001f27),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff6fbf3),
      onBackground: Color(0xff181d19),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff181d19),
      surfaceVariant: Color(0xffdce5db),
      onSurfaceVariant: Color(0xff414942),
      outline: Color(0xff717971),
      outlineVariant: Color(0xffc0c9c0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322d),
      inverseOnSurface: Color(0xffedf2eb),
      inversePrimary: Color(0xff94d5a9),
      primaryFixed: Color(0xffaff1c4),
      onPrimaryFixed: Color(0xff002110),
      primaryFixedDim: Color(0xff94d5a9),
      onPrimaryFixedVariant: Color(0xff0c5130),
      secondaryFixed: Color(0xffd1e8d5),
      onSecondaryFixed: Color(0xff0c1f14),
      secondaryFixedDim: Color(0xffb5ccba),
      onSecondaryFixedVariant: Color(0xff374b3d),
      tertiaryFixed: Color(0xffbee9f7),
      onTertiaryFixed: Color(0xff001f27),
      tertiaryFixedDim: Color(0xffa3cddb),
      onTertiaryFixedVariant: Color(0xff214c58),
      surfaceDim: Color(0xffd6dbd4),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ee),
      surfaceContainer: Color(0xffeaefe8),
      surfaceContainerHigh: Color(0xffe5eae2),
      surfaceContainerHighest: Color(0xffdfe4dd),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff054d2c),
      surfaceTint: Color(0xff2b6a46),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff43815b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff334739),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff647a6a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1d4854),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff517b87),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff6fbf3),
      onBackground: Color(0xff181d19),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff181d19),
      surfaceVariant: Color(0xffdce5db),
      onSurfaceVariant: Color(0xff3d453e),
      outline: Color(0xff59615a),
      outlineVariant: Color(0xff747d75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322d),
      inverseOnSurface: Color(0xffedf2eb),
      inversePrimary: Color(0xff94d5a9),
      primaryFixed: Color(0xff43815b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff286744),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff647a6a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4c6152),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff517b87),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff38626e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbd4),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ee),
      surfaceContainer: Color(0xffeaefe8),
      surfaceContainerHigh: Color(0xffe5eae2),
      surfaceContainerHighest: Color(0xffdfe4dd),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002914),
      surfaceTint: Color(0xff2b6a46),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff054d2c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff13261a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff334739),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00262f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1d4854),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff6fbf3),
      onBackground: Color(0xff181d19),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdce5db),
      onSurfaceVariant: Color(0xff1e2620),
      outline: Color(0xff3d453e),
      outlineVariant: Color(0xff3d453e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322d),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffb8fbcd),
      primaryFixed: Color(0xff054d2c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00341c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff334739),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1e3124),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1d4854),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00323c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbd4),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ee),
      surfaceContainer: Color(0xffeaefe8),
      surfaceContainerHigh: Color(0xffe5eae2),
      surfaceContainerHighest: Color(0xffdfe4dd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff94d5a9),
      surfaceTint: Color(0xff94d5a9),
      onPrimary: Color(0xff00391e),
      primaryContainer: Color(0xff0c5130),
      onPrimaryContainer: Color(0xffaff1c4),
      secondary: Color(0xffb5ccba),
      onSecondary: Color(0xff213528),
      secondaryContainer: Color(0xff374b3d),
      onSecondaryContainer: Color(0xffd1e8d5),
      tertiary: Color(0xffa3cddb),
      onTertiary: Color(0xff033640),
      tertiaryContainer: Color(0xff214c58),
      onTertiaryContainer: Color(0xffbee9f7),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0f1511),
      onBackground: Color(0xffdfe4dd),
      surface: Color(0xff0f1511),
      onSurface: Color(0xffdfe4dd),
      surfaceVariant: Color(0xff414942),
      onSurfaceVariant: Color(0xffc0c9c0),
      outline: Color(0xff8a938b),
      outlineVariant: Color(0xff414942),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dd),
      inverseOnSurface: Color(0xff2c322d),
      inversePrimary: Color(0xff2b6a46),
      primaryFixed: Color(0xffaff1c4),
      onPrimaryFixed: Color(0xff002110),
      primaryFixedDim: Color(0xff94d5a9),
      onPrimaryFixedVariant: Color(0xff0c5130),
      secondaryFixed: Color(0xffd1e8d5),
      onSecondaryFixed: Color(0xff0c1f14),
      secondaryFixedDim: Color(0xffb5ccba),
      onSecondaryFixedVariant: Color(0xff374b3d),
      tertiaryFixed: Color(0xffbee9f7),
      onTertiaryFixed: Color(0xff001f27),
      tertiaryFixedDim: Color(0xffa3cddb),
      onTertiaryFixedVariant: Color(0xff214c58),
      surfaceDim: Color(0xff0f1511),
      surfaceBright: Color(0xff353b36),
      surfaceContainerLowest: Color(0xff0a0f0c),
      surfaceContainerLow: Color(0xff181d19),
      surfaceContainer: Color(0xff1c211d),
      surfaceContainerHigh: Color(0xff262b27),
      surfaceContainerHighest: Color(0xff313631),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff98d9ad),
      surfaceTint: Color(0xff94d5a9),
      onPrimary: Color(0xff001b0c),
      primaryContainer: Color(0xff5f9e76),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbad0be),
      onSecondary: Color(0xff071a0f),
      secondaryContainer: Color(0xff809685),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa7d2df),
      onTertiary: Color(0xff001920),
      tertiaryContainer: Color(0xff6e97a4),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1511),
      onBackground: Color(0xffdfe4dd),
      surface: Color(0xff0f1511),
      onSurface: Color(0xfff7fcf5),
      surfaceVariant: Color(0xff414942),
      onSurfaceVariant: Color(0xffc4cdc4),
      outline: Color(0xff9da59d),
      outlineVariant: Color(0xff7d857d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dd),
      inverseOnSurface: Color(0xff262b27),
      inversePrimary: Color(0xff0e5331),
      primaryFixed: Color(0xffaff1c4),
      onPrimaryFixed: Color(0xff001508),
      primaryFixedDim: Color(0xff94d5a9),
      onPrimaryFixedVariant: Color(0xff003f23),
      secondaryFixed: Color(0xffd1e8d5),
      onSecondaryFixed: Color(0xff03150a),
      secondaryFixedDim: Color(0xffb5ccba),
      onSecondaryFixedVariant: Color(0xff273a2d),
      tertiaryFixed: Color(0xffbee9f7),
      onTertiaryFixed: Color(0xff001419),
      tertiaryFixedDim: Color(0xffa3cddb),
      onTertiaryFixedVariant: Color(0xff0c3b46),
      surfaceDim: Color(0xff0f1511),
      surfaceBright: Color(0xff353b36),
      surfaceContainerLowest: Color(0xff0a0f0c),
      surfaceContainerLow: Color(0xff181d19),
      surfaceContainer: Color(0xff1c211d),
      surfaceContainerHigh: Color(0xff262b27),
      surfaceContainerHighest: Color(0xff313631),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeffff0),
      surfaceTint: Color(0xff94d5a9),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff98d9ad),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffeffff0),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbad0be),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff4fcff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa7d2df),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1511),
      onBackground: Color(0xffdfe4dd),
      surface: Color(0xff0f1511),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff414942),
      onSurfaceVariant: Color(0xfff5fdf3),
      outline: Color(0xffc4cdc4),
      outlineVariant: Color(0xffc4cdc4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dd),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff00311a),
      primaryFixed: Color(0xffb3f6c8),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff98d9ad),
      onPrimaryFixedVariant: Color(0xff001b0c),
      secondaryFixed: Color(0xffd5edd9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbad0be),
      onSecondaryFixedVariant: Color(0xff071a0f),
      tertiaryFixed: Color(0xffc3eefc),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa7d2df),
      onTertiaryFixedVariant: Color(0xff001920),
      surfaceDim: Color(0xff0f1511),
      surfaceBright: Color(0xff353b36),
      surfaceContainerLowest: Color(0xff0a0f0c),
      surfaceContainerLow: Color(0xff181d19),
      surfaceContainer: Color(0xff1c211d),
      surfaceContainerHigh: Color(0xff262b27),
      surfaceContainerHighest: Color(0xff313631),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
