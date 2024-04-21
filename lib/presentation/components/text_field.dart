// ignore_for_file: must_be_immutable

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final String label;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.keyboardAction,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      textInputAction: widget.keyboardAction,
      maxLines: 1,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = value;
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class MyPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final String label;

  const MyPasswordField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.keyboardAction,
  });

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _visibility,
      keyboardType: widget.keyboardType,
      textInputAction: widget.keyboardAction,
      maxLines: 1,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = value;
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _visibility ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () {
            setState(() {
              _visibility = !_visibility;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class MyPhoneField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final String label;

  const MyPhoneField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.keyboardAction,
  });

  @override
  State<MyPhoneField> createState() => _MyPhoneFieldState();
}

class _MyPhoneFieldState extends State<MyPhoneField> {
  Country selectedCountry = Country(
    phoneCode: "+91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextField(
      keyboardType: widget.keyboardType,
      textInputAction: widget.keyboardAction,
      maxLines: 1,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = "${selectedCountry.phoneCode}$value";
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                countryListTheme: const CountryListThemeData(
                  bottomSheetHeight: 550,
                ),
                onSelect: (value) {
                  selectedCountry = value;
                },
              );
            },
            child: Text(
              "${selectedCountry.flagEmoji} ${selectedCountry.phoneCode}",
              style: TextStyle(
                fontSize: 18,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PinCodeField extends StatelessWidget {
  final TextEditingController otpController;
  const PinCodeField({
    super.key,
    required this.otpController,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Pinput(
      length: 6,
      showCursor: true,
      defaultPinTheme: PinTheme(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.colorScheme.onBackground,
          ),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 20,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      controller: otpController,
    );
  }
}
