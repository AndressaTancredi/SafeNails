import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class Input extends StatefulWidget {
  final String label;
  final TextInputType type;
  final bool isPassword;
  final bool isConfirmationPassword;
  final TextEditingController controller;
  final IconData? icon;
  final ValueChanged<String?>? onValueChanged;
  final String? Function(String?)? confirmPasswordValidator;

  const Input({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.isConfirmationPassword = false,
    this.type = TextInputType.text,
    this.icon,
    this.onValueChanged,
    this.confirmPasswordValidator,
  }) : super(key: key);

  @override
  InputState createState() => InputState();
}

class InputState extends State<Input> {
  bool showPass = false;

  void handleShowPass() {
    setState(() => showPass = !showPass);
  }

  TextStyle get inputText => sl<TextStyles>().inputText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        cursorColor: AppColors.pink,
        keyboardType: widget.type,
        obscureText: widget.isPassword && !showPass,
        enableSuggestions: !widget.isPassword,
        autocorrect: !widget.isPassword,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: inputText,
        decoration: InputDecoration(
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.pink,
          )),
          errorStyle:
              TextStyle(color: AppColors.pink, fontWeight: FontWeight.w500),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.pink,
          )),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.pink,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.pink,
            ),
          ),
          helperStyle: TextStyle(color: AppColors.pink),
          filled: true,
          fillColor: Colors.transparent,
          constraints: const BoxConstraints(
            minWidth: double.infinity,
          ),
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          hintText: widget.label,
          hintStyle: inputText,
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  size: 16,
                )
              : null,
          prefixIconColor: AppColors.pink,
          suffix: widget.isPassword
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    splashRadius: 16,
                    icon: showPass
                        ? const Icon(
                            Icons.remove_red_eye_rounded,
                            size: 16,
                            color: AppColors.pink,
                          )
                        : const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                            color: AppColors.pink,
                          ),
                    iconSize: 16,
                    onPressed: handleShowPass,
                  ),
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.label} ${CommonStrings.obligatory}';
          } else if (widget.type == TextInputType.emailAddress) {
            if (!emailValidator(value)) {
              return CommonStrings.invalidEmail;
            }
          } else if (widget.isPassword && value.length < 8) {
            if (value.length < 8) {
              return CommonStrings.conditionPass;
            }
          } else if (widget.isConfirmationPassword) {
            return widget.confirmPasswordValidator!(value);
          }
          return null;
        },
      ),
    );
  }

  emailValidator(text) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }
}
