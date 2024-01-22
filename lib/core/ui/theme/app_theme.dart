import 'package:flutter/material.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/resources/fonts.gen.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        fontFamily: FontFamily.saro,
        textTheme: _textTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        textSelectionTheme: _textSelectionTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        appBarTheme: _appBarTheme,
        bottomSheetTheme: _bottomSheetTheme,
        dividerColor: AppColors.darkGray,
      );
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(),
        fontFamily: FontFamily.saro,
        textTheme: _textThemeDark,
        elevatedButtonTheme: _elevatedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationThemeDark,
        textSelectionTheme: _textSelectionTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        appBarTheme: _appBarThemeDark,
        bottomSheetTheme: _bottomSheetTheme,
        dividerColor: AppColors.darkGray,
      );

  // primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
  static get _textThemeDark => _textTheme.apply(displayColor: AppColors.white);

  static get _textTheme => const TextTheme(
        displayLarge: TextStyle(fontSize: 44),
        displayMedium: TextStyle(fontSize: 40),
        displaySmall: TextStyle(fontSize: 36),
        headlineLarge: TextStyle(fontSize: 48),
        headlineMedium: TextStyle(fontSize: 44),
        headlineSmall: TextStyle(fontSize: 42),
        titleLarge: TextStyle(fontSize: 40),
        titleMedium: TextStyle(fontSize: 34),
        titleSmall: TextStyle(fontSize: 32),
        bodyLarge: TextStyle(fontSize: 28),
        bodyMedium: TextStyle(fontSize: 26),
        bodySmall: TextStyle(fontSize: 22),
        labelLarge: TextStyle(fontSize: 30),
        labelMedium: TextStyle(fontSize: 28),
        labelSmall: TextStyle(
          fontSize: 20,
          height: 20 / 22,
          letterSpacing: 1,
        ),
      ).apply(displayColor: AppColors.black);

  static get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColors.primary,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 4, horizontal: 12)),
          elevation: MaterialStateProperty.all(0),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 40,
              fontFamily: FontFamily.saro,
            ),
          ),
        ),
      );

  static get _textButtonTheme => TextButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          foregroundColor: MaterialStateProperty.all(AppColors.primary),
          overlayColor:
              MaterialStateProperty.all(AppColors.primary.withOpacity(0.2)),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 30,
              fontFamily: FontFamily.saro,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );

  static InputDecorationTheme get _inputDecorationTheme =>
      const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.ternary, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary, width: 2.4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
        ),
        labelStyle: TextStyle(fontSize: 28, color: AppColors.textColorBlack),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorStyle: TextStyle(fontSize: 24, color: AppColors.errorColor),
        helperStyle: TextStyle(color: AppColors.black),
        counterStyle: TextStyle(fontSize: 20, color: AppColors.grey),
      );

  static get _inputDecorationThemeDark => _inputDecorationTheme.copyWith(
      labelStyle: _inputDecorationTheme.labelStyle!
          .copyWith(color: AppColors.lightPrimary),
      helperStyle: _inputDecorationTheme.helperStyle!
          .copyWith(color: AppColors.lightPrimary));

  static get _textSelectionTheme => const TextSelectionThemeData(
        cursorColor: AppColors.ternary,
      );

  static get _progressIndicatorTheme =>
      const ProgressIndicatorThemeData(color: AppColors.white);

  static get _appBarTheme => const AppBarTheme(elevation: 0);

  static get _appBarThemeDark => const AppBarTheme(elevation: 0);

  static get _bottomSheetTheme => const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
      );
}
