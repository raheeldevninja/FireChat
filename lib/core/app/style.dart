import 'package:flutter/material.dart';

final lightTheme = _getTheme(brightness: Brightness.light);
final darkTheme = _getTheme(brightness: Brightness.dark);

const _primary = Colors.white;
const _secondary = Colors.black;

const _background = Colors.white;
const _lightest = Colors.white;
const _darkest = Colors.black;
const _divider = Colors.grey;
const _disabled = Colors.grey;
const _red = Colors.red;
const _green = Colors.green;
const _grey = Colors.grey;
const _textFormFieldColor = Color(0xFFEBF0F5);

const _darkFontColor = Colors.white;
const _darkBackground = Color(0xFF1E1E1E);
const _darkDivider = Colors.grey;
final _darkPrimaryContainer = _primary.withValues(alpha: 0.2);
final _darkSecondaryContainer = _secondary.withValues(alpha: 0.2);
final _darkTextFormFieldColor = _grey.withValues(alpha: 0.3);


final _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // Primary
  primary: _primary,
  onPrimary: _secondary,
  primaryContainer: _primary.withValues(alpha: 0.2),
  onPrimaryContainer: _lightest,
  onPrimaryFixed: _primary,

  // Secondary
  secondary: _secondary,
  onSecondary: _darkest,
  secondaryContainer: _background.withValues(alpha: 0.15),
  onSecondaryContainer: _background.withValues(alpha: 0.7),
  //tertiary
  tertiary: _green,
  onTertiary: _secondary,
  onTertiaryContainer: _grey.withValues(alpha: 0.1),
  tertiaryFixedDim: _grey,
  tertiaryContainer: _secondary,

  // Error
  error: _red,
  onError: _lightest,
  // Background
  surface: _primary,
  onSurface: _secondary,
  surfaceContainer: _textFormFieldColor,
  onSurfaceVariant: _grey,

  // Outline
  outline: _divider.withValues(alpha: 0.4),
  outlineVariant: _divider.withValues(alpha: 0.2),
);

final _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  // Primary
  primary: _secondary,
  onPrimary: _darkFontColor,
  primaryContainer: _darkPrimaryContainer,
  onPrimaryContainer: _darkFontColor,
  onPrimaryFixed: _primary,

  // Secondary
  secondary: _secondary,
  onSecondary: _lightest,
  secondaryContainer: _darkSecondaryContainer,
  onSecondaryContainer: _darkest,

  //tertiary
  tertiary: _green,
  onTertiary: _lightest,
  onTertiaryContainer:  _grey.withValues(alpha: 0.4),
  tertiaryFixedDim: _grey,
  tertiaryContainer: _grey.withValues(alpha: 0.3),


  // Error
  error: _red,
  onError: _lightest,
  // Surface
  surface: _darkBackground,
  onSurface: _primary,
  surfaceContainer: _darkTextFormFieldColor,
  onSurfaceVariant: _grey,

  // Outline
  outline: _darkDivider,
  outlineVariant: _divider.withValues(alpha: 0.2),
);


ThemeData _getTheme({required Brightness brightness}) {

  final colorScheme = switch (brightness) {
    Brightness.light => _lightColorScheme,
    Brightness.dark => _darkColorScheme,
  };

  final textTheme = _getTextTheme(colorScheme);
  final primaryTextTheme = textTheme.apply(
    displayColor: colorScheme.onPrimary,
    bodyColor: colorScheme.onPrimary,
  );

  final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  );

  const buttonPadding = EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16
  );

  final buttonTextStyle = textTheme.bodyLarge!.copyWith(
    fontWeight: FontWeight.w600,
  );

  final textButtonTextStyle = textTheme.bodyMedium;
  final appBarTextStyle = textTheme.titleMedium;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    textTheme: textTheme,
    primaryTextTheme: primaryTextTheme,
    scaffoldBackgroundColor: colorScheme.surface,
    disabledColor: _disabled,
    dividerTheme: DividerThemeData(
      color: colorScheme.outline,
      thickness: 1,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      centerTitle: true,
      titleTextStyle: appBarTextStyle,
      elevation: 3.0,
    ),
    cardTheme: CardThemeData(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: colorScheme.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: false,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: textTheme.labelMedium?.copyWith(color: colorScheme.secondary),
      selectedShadowColor: Colors.transparent,
      backgroundColor: colorScheme.tertiary,
      elevation: 0,
      side: const BorderSide(
        color: Colors.transparent,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: colorScheme.primary,
      selectedItemColor: colorScheme.onSurface,
      unselectedItemColor: colorScheme.tertiaryFixedDim,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      titleTextStyle: textTheme.titleLarge,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: _darkest,
      contentTextStyle: primaryTextTheme.bodyLarge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: colorScheme.onSecondary,
      titleTextStyle: textTheme.bodyLarge,
    ),
    iconTheme: IconThemeData(
      color: colorScheme.onSurface,
      size: 28,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(colorScheme.onPrimaryFixed),
      trackColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onTertiaryContainer;
          }
          return colorScheme.onSurfaceVariant;
        },
      ),
      overlayColor: WidgetStateProperty.all(colorScheme.primary.withValues(alpha: 0.2)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: const CircleBorder(),
      elevation: 8,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: buttonPadding,
        backgroundColor: colorScheme.secondary,
        foregroundColor: _lightest,
        textStyle: buttonTextStyle,
        elevation: 2,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onSecondary;
          }
          return colorScheme.primary;
        },
      ),
      checkColor: WidgetStateProperty.all(colorScheme.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      side: BorderSide(
        color: colorScheme.onSecondary,
        width: 2,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: buttonShape,
        padding: buttonPadding,
        side: BorderSide(
          color: colorScheme.tertiaryContainer,
          width: 1,
        ),
        backgroundColor: colorScheme.tertiaryContainer,
        foregroundColor: colorScheme.onPrimaryFixed,
        textStyle: buttonTextStyle,
        elevation: 0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: buttonShape,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onTertiary,
        textStyle: textButtonTextStyle,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        elevation: 4,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainer,
      suffixIconColor: colorScheme.onSurface,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.0),
      ),
      hintStyle: textTheme.bodyMedium!.copyWith(
        color: colorScheme.onSecondary,
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSecondary,
      ),
    ),

  );
}

TextTheme _getTextTheme(ColorScheme colorScheme) {

  final headlineColor = colorScheme.onSurface;
  const headlineWeight = FontWeight.w700;
  const headlineHeight = 1.2;

  final titleColor = colorScheme.onSurface;
  const titleWeight = FontWeight.w500;
  const titleHeight = 1.2;
  const titleLetterSpacing = -0.96;

  final bodyColor = colorScheme.onSurface;
  const bodyWeight = FontWeight.normal;
  const bodyHeight = 1.5;
  const bodyLetterSpacing = 0.0;

  final labelColor = titleColor;

  final textTheme = TextTheme(
    // Headline
    headlineLarge: TextStyle(
      fontSize: 32,
      color: headlineColor,
      fontWeight: headlineWeight,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      color: headlineColor,
      fontWeight: headlineWeight,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      height: headlineHeight,
      //letterSpacing: headlineLetterSpacing,
      color: headlineColor,
      fontWeight: headlineWeight,
    ),

    // Title
    titleLarge: TextStyle(
      fontSize: 20,
      height: titleHeight,
      letterSpacing: titleLetterSpacing,
      color: titleColor,
      fontWeight: titleWeight,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      height: titleHeight,
      letterSpacing: titleLetterSpacing,
      color: titleColor,
      fontWeight: titleWeight,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      height: titleHeight,
      color: titleColor,
      fontWeight: titleWeight,
    ),

    // Body
    bodyLarge: TextStyle(
      fontSize: 16,
      height: bodyHeight,
      letterSpacing: bodyLetterSpacing,
      color: bodyColor,
      fontWeight: bodyWeight,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: bodyHeight,
      letterSpacing: bodyLetterSpacing,
      color: bodyColor,
      fontWeight: bodyWeight,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      height: bodyHeight,
      color: bodyColor,
      fontWeight: bodyWeight,
    ),

    // Label
    labelLarge: TextStyle(
      fontSize: 16,
      height: bodyHeight,
      letterSpacing: bodyLetterSpacing,
      color: labelColor,
      fontWeight: bodyWeight,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      height: bodyHeight,
      letterSpacing: bodyLetterSpacing,
      color: labelColor,
      fontWeight: bodyWeight,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      height: bodyHeight,
      letterSpacing: bodyLetterSpacing,
      color: labelColor,
      fontWeight: bodyWeight,
    ),
  );


  return textTheme;
}


