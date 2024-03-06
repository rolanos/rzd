// Create an input widget that takes only one digit
import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

class OtpInput extends StatefulWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final bool? isLast;
  final Function onChange;

  const OtpInput(this.controller, this.autoFocus,
      {Key? key, this.isLast, required this.onChange})
      : super(key: key);

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: TextField(
        autofocus: widget.autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: widget.controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        onChanged: (value) {
          widget.onChange();
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
            setState(() {});
            if (widget.isLast == true) {
              FocusScope.of(context).unfocus();
            }
          }
        },
        decoration: InputDecoration(
          border: (widget.controller.text.isNotEmpty)
              ? InputBorder.none
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorsUI.otpBorder)),
          counterText: '',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 20.0,
              ),
        ),
      ),
    );
  }
}
