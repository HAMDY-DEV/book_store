import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.label,
    this.validator,
    this.onChanged,
    this.onTapVisibility,
    this.obscureText,
    this.controller,
    this.keyboardType,
  });
  final String hintText;
  final String label;
  TextInputType? keyboardType;
  TextEditingController? controller;
  bool? obscureText;
  void Function()? onTapVisibility;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: obscureText == null
            ? const SizedBox()
            : IconButton(
                onPressed: onTapVisibility,
                icon: Icon(
                  obscureText == true ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primaryColor,
                )),
        hintText: hintText,
        hintStyle: getSmallStyle(context, color: AppColors.greyColor),
        label: Text(
          label,
          style: getBodyStyle(context, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
