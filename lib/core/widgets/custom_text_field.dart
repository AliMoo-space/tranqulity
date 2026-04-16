import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_dimensions.dart';
import 'package:tranqulity/core/styling/app_styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final double? width;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.width,
    this.isPassword,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  bool _obscureText = true;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 331.w,
      child: TextFormField(
        focusNode: _focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        onChanged: widget.onChanged,
        controller: widget.controller,
        validator: widget.validator,
        autofocus: false,
        obscureText: widget.isPassword == true ? _obscureText : false,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText ?? "",
          hintStyle: AppStyles.label15MediumMutedStyle,
          contentPadding: EdgeInsets.symmetric(
            horizontal: (AppDimensions.lg + 2).w,
            vertical: (AppDimensions.lg + 2).h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.inputRadius.r),
            borderSide: const BorderSide(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.inputRadius.r),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.inputRadius.r),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.inputRadius.r),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          filled: true,
          fillColor: AppColors.surfaceColor,
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.greyColor,
                    size: 20.sp,
                  ),
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }
}
