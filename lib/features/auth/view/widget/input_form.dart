import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';

class InputForm extends StatefulWidget {
  final String? errorText;
  final String hintText;
  final TextEditingController controller;
  final Color? color;

  final TextInputType? textInputType;

  final bool? obscureText;

  final TextStyle? inputStyle;

  final Validator? validator;

  final void Function(String)? onChanged;

  final List<TextInputFormatter>? inputFormatters;

  final Widget? trailing;

  final GlobalKey? formKey;

  final bool enabled;

  final Function? onTap;

  final bool isRequired;

  final bool readOnly;

  const InputForm({
    super.key,
    this.errorText,
    required this.hintText,
    required this.controller,
    this.color,
    this.validator,
    this.textInputType,
    this.obscureText,
    this.inputStyle,
    this.inputFormatters,
    this.trailing,
    this.onChanged,
    this.formKey,
    this.enabled = true,
    this.onTap,
    this.isRequired = false,
    this.readOnly = false,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool isCorrect = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              inputFormatters: widget.inputFormatters,
              validator: (value) {
                if (value == null) {
                  isCorrect = false;
                  return '';
                }
                if (value.isEmpty && widget.isRequired == false) {
                  return null;
                }
                if (value.isEmpty ||
                    widget.validator?.validate(value) == false) {
                  setState(() {
                    isCorrect = false;
                  });
                  return widget.errorText;
                }
                isCorrect = true;
                return null;
              },
              controller: widget.controller,
              obscureText: widget.obscureText ?? false,
              obscuringCharacter: "●",
              style:
                  widget.inputStyle ?? Theme.of(context).textTheme.bodyMedium,
              keyboardType: widget.textInputType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 18.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.color ??
                        ((isCorrect == true)
                            ? ColorsUI.containerLightGrey
                            : ColorsUI.inactiveRedLight),
                  ),
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                suffixIconConstraints:
                    BoxConstraints(maxHeight: 18, maxWidth: 18 + 24),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: widget.trailing ?? SizedBox(),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.color ??
                        ((isCorrect == true)
                            ? ColorsUI.containerLightGrey
                            : ColorsUI.inactiveRedLight),
                  ),
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.color ??
                        ((isCorrect == true)
                            ? ColorsUI.containerLightGrey
                            : ColorsUI.inactiveRedLight),
                  ),
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                filled: true,
                fillColor: widget.color ??
                    ((isCorrect == true)
                        ? ColorsUI.containerLightGrey
                        : ColorsUI.inactiveRedLight),
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: ColorsUI.secondaryText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
