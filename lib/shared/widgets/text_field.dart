import 'package:egov/core/viewmodels/view_models.dart';
import 'package:egov/shared/utils/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.hintText,
    this.label,
    required this.obscureText,
    required this.textInputType,
    required this.validator,
    required this.controller,
    required this.textInputAction,
    this.hasSuffixIcon = false,
    this.inputFormatters,
    this.textAlign,
    this.onChanged,
    this.suffixImage,
    this.hasBgsuffixIcon = true,
    this.suffixIcon,
    this.initialValue,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);
  final Widget? suffixIcon;
  final String hintText;
  final String? label, suffixImage, initialValue;
  final bool obscureText;
  final bool? hasSuffixIcon, hasBgsuffixIcon;
  final TextInputType textInputType;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return TextFormField(
      style: themeProvider.textTheme().headline3,
      inputFormatters: inputFormatters,
      textAlign: textAlign ?? TextAlign.start,
      validator: validator,
      initialValue: initialValue,
      keyboardType: textInputType,
      obscureText: obscureText,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: (horizontalPadding),
          vertical: (smallVerticalPadding),
        ),
        filled: true,
        fillColor: themeProvider.themeMode().kcolorTextField,
        hintText: hintText,
        hintStyle: themeProvider.textTheme().bodyText2,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius ?? (textFieldBorderRadius) / 2),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              borderRadius ?? (textFieldBorderRadius) / 2),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        disabledBorder: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              borderRadius ?? (textFieldBorderRadius) / 2),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              borderRadius ?? (textFieldBorderRadius) / 2),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.4),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              borderRadius ?? (textFieldBorderRadius) / 2),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.4),
          ),
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: (buttonBorderRadius),
        ),
        suffixIcon: hasSuffixIcon!
            ? suffixIcon ??
                Padding(
                  padding: EdgeInsets.only(
                    right: (smallHorizontalPadding),
                    top: (smallVerticalPadding) / 2,
                    bottom: (smallVerticalPadding) / 2,
                  ),
                  child: Container(
                    width: (buttonHeight),
                    padding: EdgeInsets.symmetric(
                        horizontal: (textFieldBorderRadius) / 4,
                        vertical: (textFieldBorderRadius) / 3),
                    decoration: BoxDecoration(
                      color: hasBgsuffixIcon!
                          ? Colors.white.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular((textFieldBorderRadius) / 5),
                    ),
                    child: SizedBox(
                      height: (padding) / 2,
                      child: SvgPicture.asset(
                        suffixImage ?? '',
                        color: themeProvider.themeMode().kycCardTextColor,
                      ),
                    ),
                  ),
                )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class MultiLineTextFieldWidget extends StatelessWidget {
  const MultiLineTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    required this.textInputAction,
  }) : super(key: key);
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      style: themeProvider.textTheme().bodyText1,
      keyboardType: textInputType,
      controller: controller,
      textInputAction: textInputAction,
      maxLines: 5,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: (horizontalPadding),
          vertical: (smallVerticalPadding),
        ),
        filled: true,
        fillColor: themeProvider.themeMode().kcolorTextField,
        hintText: hintText,
        hintStyle: themeProvider.textTheme().bodyText2,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular((textFieldBorderRadius) / 2),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular((textFieldBorderRadius) / 2),
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        disabledBorder: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular((textFieldBorderRadius) / 2),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular((textFieldBorderRadius) / 2),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.4),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular((textFieldBorderRadius) / 2),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.4),
          ),
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: (buttonBorderRadius),
        ),
      ),
    );
  }
}

class ColoredTextField extends StatelessWidget {
  const ColoredTextField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.hasPadding,
    required this.textInputType,
    required this.validator,
    required this.controller,
    required this.textInputAction,
    this.inputFormatters,
    this.suffixText,
    this.textAlign,
    this.onChanged,
    this.suffixIcon,
    this.onTap,
    this.suffixStyle,
  }) : super(key: key);
  final String hintText;
  final String? suffixText;
  final bool obscureText, hasPadding;
  final TextInputType textInputType;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final bool? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final TextStyle? suffixStyle;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return !hasPadding
        ? TextFormField(
            style: themeProvider.textTheme().bodyText1,
            inputFormatters: inputFormatters,
            textAlign: textAlign ?? TextAlign.start,
            validator: validator,
            readOnly: onTap != null ? true : false,
            keyboardType: textInputType,
            obscureText: obscureText,
            controller: controller,
            onTap: onTap,
            onChanged: onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction:
                textInputAction! ? TextInputAction.done : TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: (horizontalPadding),
              ),
              hintText: hintText,
              suffixText: suffixText,
              suffixIcon: suffixIcon ?? const SizedBox.shrink(),
              filled: true,
              fillColor: const Color(0xffADEDE3),
              hintStyle: GoogleFonts.poppins(
                fontSize: (textFontSize),
                color: textColor.withOpacity(
                  0.6,
                ),
                fontWeight: FontWeight.w600,
              ),
              suffixStyle: suffixStyle ??
                  GoogleFonts.poppins(
                    fontSize: (header2FontSize),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
              border: !hasPadding
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular((textFieldBorderRadius) / 2),
                      borderSide: BorderSide.none,
                    ),
              focusedBorder: !hasPadding
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular((textFieldBorderRadius) / 2),
                      borderSide: BorderSide(
                        color: primaryColor,
                      ),
                    ),
              disabledBorder: InputBorder.none,
              enabledBorder: !hasPadding
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular((textFieldBorderRadius) / 2),
                      borderSide: BorderSide.none,
                    ),
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorStyle: GoogleFonts.poppins(
                fontSize: (buttonBorderRadius),
              ),
            ),
          )
        : Column(
            children: [
              TextFormField(
                style: themeProvider.textTheme().bodyText1,
                inputFormatters: inputFormatters,
                textAlign: textAlign ?? TextAlign.start,
                validator: validator,
                readOnly: onTap != null ? true : false,
                keyboardType: textInputType,
                obscureText: obscureText,
                controller: controller,
                onTap: onTap,
                onChanged: onChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: textInputAction!
                    ? TextInputAction.done
                    : TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: (horizontalPadding),
                  ),
                  hintText: hintText,
                  suffixText: suffixText,
                  suffixIcon: suffixIcon ?? const SizedBox.shrink(),
                  filled: true,
                  fillColor: const Color(0xffADEDE3),
                  hintStyle: GoogleFonts.poppins(
                    fontSize: (textFontSize),
                    color: textColor.withOpacity(
                      0.6,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                  suffixStyle: GoogleFonts.poppins(
                    fontSize: (header2FontSize),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular((textFieldBorderRadius) / 2),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular((textFieldBorderRadius) / 2),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  disabledBorder: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular((textFieldBorderRadius) / 2),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular((textFieldBorderRadius) / 2),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular((textFieldBorderRadius) / 2),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  errorStyle: GoogleFonts.poppins(
                    fontSize: (buttonBorderRadius),
                  ),
                ),
              ),
              HSpace(
                (verticalPadding),
              ),
            ],
          );
  }
}
