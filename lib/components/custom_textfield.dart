import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp2/core/base/base_state.dart';

class CustomTextField extends StatelessWidget {
  final double? topPadding;
  final Widget? prefixIcon;
  final bool? readonly;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final bool? isSearchable;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    this.topPadding,
    this.readonly,
    this.hintText,
    this.controller,
    this.obscureText,
    this.validator,
    this.keyboardType,
    this.labelText,
    this.prefixIcon,
    this.isSearchable,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: topPadding!),
        child: TextFormField(
          onChanged: onChanged,
          autofocus: false,
          validator: validator!,
          inputFormatters: inputFormatters,
          controller: controller,
          cursorColor: const Color(0xFFff6b6b),
          obscureText: obscureText ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          readOnly: readonly ?? false,
          toolbarOptions: const ToolbarOptions(copy: false, paste: false),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(bottom: 13.0, top: 13.0, left: 16.0),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: prefixIcon,
            ),
            prefixIconConstraints:
                BoxConstraints.tightFor(height: Utility.dynamicWidthPixel(50)),
            filled: isSearchable! ? true : false,
            fillColor: Colors.grey[200],
            border: isSearchable!
                ? OutlineInputBorder(
                    borderSide: const BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(6.0),
                  )
                : UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
            focusedBorder: isSearchable!
                ? OutlineInputBorder(
                    borderSide: const BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(6.0),
                  )
                : UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
            enabledBorder: isSearchable!
                ? OutlineInputBorder(
                    borderSide: const BorderSide(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(6.0),
                  )
                : UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(color: Colors.black),
            labelText: labelText,

            //floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }
}
