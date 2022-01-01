import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemes {
  static ThemeData get darkTheme => ThemeData(
        appBarTheme: AppBarTheme(color: AppColors.colorAppBar),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.colorAccentDark,
          errorColor: AppColors.errorColorDark,
        ),
        unselectedWidgetColor: AppColors.disabledTextDark,
        cardColor: AppColors.cardColorDark,
        canvasColor: AppColors.screenBackgroundDark,
        dividerColor: AppColors.disabledTextDark,
        primaryColor: AppColors.colorPrimaryDark,
        textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.colorAccentDark),
        scaffoldBackgroundColor: AppColors.screenBackgroundDark,
        textTheme: TextTheme(
          headline1: TextStyle(color: AppColors.highEmphasisTextDark),
          headline2: TextStyle(color: AppColors.highEmphasisTextDark),
          headline3: TextStyle(color: AppColors.highEmphasisTextDark),
          headline4: TextStyle(
            color: AppColors.disabledTextDark,
            fontSize: 18,
          ),
          headline5: TextStyle(color: AppColors.mediumEmphasisTextDark),
          headline6: TextStyle(color: AppColors.highEmphasisTextDark),
          subtitle1: TextStyle(color: AppColors.highEmphasisTextDark),
          subtitle2: TextStyle(color: AppColors.highEmphasisTextDark),
          bodyText1: TextStyle(color: AppColors.highEmphasisTextDark),
          bodyText2: TextStyle(color: AppColors.highEmphasisTextDark),
          button: TextStyle(color: AppColors.highEmphasisTextDark),
          caption: TextStyle(color: AppColors.highEmphasisTextDark),
          overline: TextStyle(color: AppColors.highEmphasisTextDark),
        ),
      );
}
