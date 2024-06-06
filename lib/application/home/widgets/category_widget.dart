import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {
  final String? categoryName;
  final bool isCheck;

  const CategoryWidget(
      {super.key, required this.categoryName, required this.isCheck});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.sp),
        color: isCheck ? Colors.green : Colors.green.shade300,
      ),
      width: 100.w,
      child: Text(
              categoryName ?? "",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isCheck ? FontWeight.bold : FontWeight.normal,
                color: isCheck ? Colors.white : Colors.blueGrey,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
    );
  }
}
