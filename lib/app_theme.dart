import 'package:flutter/material.dart';

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  // isDarkTheme = getIt<AppStore>().isDarkMode;
  return ThemeData(
    textTheme: TextTheme(
      displayMedium: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      displaySmall: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      displayLarge: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      bodySmall: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      bodyMedium: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      bodyLarge: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      titleMedium: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      titleLarge: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      headlineSmall: TextStyle(
          color:
              isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
    ),
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
          kAppColor:
              isDarkTheme ? const Color(0xff2B3C4E) : const Color(0xff2B3C4E),
         ),
    ],
  );
}

class AppColors extends ThemeExtension<AppColors> {
  final Color? kAppColor;
 
  const AppColors(
      {required this.kAppColor,
      });

  @override
  AppColors copyWith({
    Color? kAppColor,
    
  }) {
    return AppColors(
        kAppColor: kAppColor ?? this.kAppColor,
       );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      kAppColor: Color.lerp(kAppColor, other.kAppColor, t),
    
    );
  }
}
