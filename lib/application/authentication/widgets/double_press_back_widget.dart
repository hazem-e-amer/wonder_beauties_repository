import 'package:flutter/material.dart';
import 'package:wonder_beauties/core/utils/common.dart';

DateTime? _currentBackPressTime;

class DoublePressBackWidget extends StatelessWidget {
  final Widget child;
  final String? message;
  final Color? bgColor;
  final Color? textColor;
  final WillPopCallback? onWillPop;

  const DoublePressBackWidget({
    Key? key,
    required this.child,
    this.message,
    this.bgColor,
    this.textColor,
    this.onWillPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () {
        DateTime now = DateTime.now();

        onWillPop?.call();
        if (_currentBackPressTime == null ||
            now.difference(_currentBackPressTime!) >
                const Duration(seconds: 2)) {
          _currentBackPressTime = now;
          toast(
            message ?? 'Press back again to exit',
            bgColor: bgColor ?? Colors.white,
            textColor: textColor ?? Colors.green,
          );

          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}
