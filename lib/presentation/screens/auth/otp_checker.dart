import 'package:chatsphere/presentation/components/elevated_btn.dart';
import 'package:chatsphere/presentation/components/text_field.dart';
import 'package:chatsphere/presentation/helpers/auth_gate.dart';
import 'package:chatsphere/presentation/helpers/auth_service.dart';
import 'package:chatsphere/presentation/screens/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpChecker extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpChecker({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<OtpChecker> createState() => _OtpCheckerState();
}

class _OtpCheckerState extends State<OtpChecker> {
  bool isLoading = false;

  final GetIt getIt = GetIt.instance;
  late AuthService authService;

  final otpController = TextEditingController();

  void onOtpSubmit() async {
    final result = await authService.otpSignIn(
      otpController.text.trim(),
      widget.verificationId,
    );
    if (result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthGate(),
        ),
      );
    }
  }

  void onEmailAuth() {
    Navigator.pop(context);
  }

  void onGoogleSignUp() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await authService.googleAuth();
      if (result) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error, ${e.toString()}",
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onChangeAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    authService = getIt.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(22.0),
      child: _buildUi(),
    )));
  }

  Widget _buildUi() {
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text
          const SizedBox(
            height: 30,
          ),
          // Text
          Text(
            'Enter code sent to your phone.',
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            'we sent to ${widget.phoneNumber}.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          // phone number
          const SizedBox(
            height: 85,
          ),
          PinCodeField(otpController: otpController),
          const SizedBox(
            height: 170,
          ),
          MyElevatedButton(
            onPressed: onOtpSubmit,
            text: 'Submit',
            mheight: 40,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                thickness: 1.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'or sign in with',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Divider(
                thickness: 1.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          // phone
          GestureDetector(
            onTap: onEmailAuth,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  // Border
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // Icon
                    Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    // Text
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Email & Password',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // google
          GestureDetector(
            onTap: onGoogleSignUp,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  // Border
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // Icon
                    Image.asset(
                      'assets/icons/google.png',
                      height: 24,
                      width: 24,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    // Text
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Google account',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: onChangeAuth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Return back?",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Click here!',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
