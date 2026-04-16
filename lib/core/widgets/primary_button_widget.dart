import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

class AppPrimaryButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final double? width;
  final double? height;
  final double? bordersRadius;
  final Color? textColor;
  final double? fontSize;
  final Widget? icon;
  final Widget? trailingIcon;
  final void Function()? onPress;
  final bool isLoading;
  const AppPrimaryButton({
    super.key,
    this.buttonText,
    this.buttonColor,
    this.width,
    this.height,
    this.bordersRadius,
    this.fontSize,
    this.textColor,
    this.icon,
    this.trailingIcon,
    this.onPress,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(bordersRadius ?? 8.r),
        ),
        fixedSize: Size(width ?? 331.w, height ?? 70.h),
      ),
      child: isLoading
          ? SizedBox(
              width: 30.sp,
              height: 30.sp,
              child: const CircularProgressIndicator(color: Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? icon! : const SizedBox.shrink(),
                icon != null ? const WidthSpace(8) : const SizedBox.shrink(),
                Text(
                  buttonText ?? "",
                  style: AppStyles.body16MediumStyle.copyWith(
                    color: textColor ?? AppColors.whiteColor,
                    fontSize: fontSize ?? 16.sp,
                  ),
                ),
                trailingIcon != null
                    ? const WidthSpace(8)
                    : const SizedBox.shrink(),
                trailingIcon != null ? trailingIcon! : const SizedBox.shrink(),
              ],
            ),
    );
  }
}

@Deprecated('Use AppPrimaryButton instead')
class PrimrayButtonWidget extends AppPrimaryButton {
  const PrimrayButtonWidget({
    super.key,
    super.buttonText,
    super.buttonColor,
    super.width,
    super.height,
    super.bordersRadius,
    super.fontSize,
    super.textColor,
    super.icon,
    super.trailingIcon,
    super.onPress,
    super.isLoading,
  });
}
