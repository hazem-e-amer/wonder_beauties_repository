import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Functions {
  static void printWarning(String text) {
    if (kDebugMode) {
      print('\x1B[33m$text\x1B[0m');
    }
  }

  static void printError(String text) {
    if (kDebugMode) {
      print('\x1B[31m$text\x1B[0m');
    }
  }

  static void printNormal(String text) {
    if (kDebugMode) {
      print('\x1B[36m$text\x1B[0m');
    }
  }

  static void printDone(String text) {
    if (kDebugMode) {
      print('\x1B[32m$text\x1B[0m');
    }
  }

  static Size textSize({
    required String text,
    required TextStyle? style,
    int maxLines = 1,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }

  static void showLoaderFunction({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (_context) => Center(
        child: Container(
          height: 75.h,
          width: 75.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: const [
              BoxShadow(
                color: Colors.green,
                offset: Offset(0.0, 0.0),
                blurRadius: 7.5,
                spreadRadius: 0.75,
              ),
            ],
          ),
          child: LoadingAnimationWidget.hexagonDots(
            color: Colors.green,
            size: 50.sp,
          ),
        ),
      ),
    );
  }

  static void showDialogFunction(
      {required BuildContext context,
      required String data,
      Function()? onTapYes}) {
    showDialog(
      context: context,
      builder: (_context) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 300.h, horizontal: 35.w),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: const [
              BoxShadow(
                color: Colors.green,
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.sp,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(_context);
                          if (onTapYes != null) {
                            onTapYes();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15.sp),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(
                            'Yes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(_context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15.sp),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      barrierColor: Colors.transparent,
    );
  }
}
