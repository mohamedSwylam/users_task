import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfection_task/core/theming/colors.dart';
import 'package:perfection_task/core/theming/font_weight.dart';

class TextStyles {
  static TextStyle font24BlackBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWightHelper.bold,
    color: Colors.black,
  );

  static TextStyle font15DarkBlueMedium = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWightHelper.medium,
    color: ColorsManger.darkBlue,
  );

  static TextStyle font14GrayRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWightHelper.regular,
    color: ColorsManger.gray,
  );

  static TextStyle font14GrayMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWightHelper.medium,
    color: ColorsManger.lightGray,
  );

  static TextStyle font11blueRegular = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWightHelper.regular,
    color: ColorsManger.darkBlue,
  );
}
