import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlternateGoogleAuthCard extends StatelessWidget {
  final String asset = 'assets/icons/google.png';
  final String text;

  const AlternateGoogleAuthCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon
        Image.asset(
          asset,
          height: 24,
          width: 24,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        // Text
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}

class AlternateAuthCard extends StatelessWidget {
  final IconData asset;
  final String text;
  const AlternateAuthCard({
    super.key,
    required this.asset,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon
        Icon(
          asset,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        // Text
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
