import 'package:chatsphere/presentation/components/elevated_btn.dart';
import 'package:chatsphere/presentation/components/text_field.dart';
import 'package:chatsphere/presentation/screens/auth/auth_page.dart';
import 'package:chatsphere/presentation/screens/auth/otp_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final phoneController = TextEditingController();

  void onPhoneSubmit() {
    verifyPhoneNumber(phoneController.text.trim());
  }

  void onEmailAuth() {
    Navigator.pop(context);
  }

  void onGoogleSignUp() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      auth.signInWithProvider(googleAuthProvider);
    } catch (error) {
      debugPrint(error.toString());
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

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtpChecker(verificationId: verificationId, phoneNumber: phoneController.text.trim(),),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Auto-retrieval timed out"),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );

        debugPrint("Auto-retrieval timed out: $verificationId");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: _buildUi(),
        ),
      ),
    );
  }

  Widget _buildUi() {
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
            'Enter your mobile number.',
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            'We will send you a confirmation code',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          // phone number
          const SizedBox(
            height: 85,
          ),
          MyPhoneField(
            hintText: "Phone Number",
            controller: phoneController,
            keyboardType: TextInputType.phone,
            label: "Phone Number",
            keyboardAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 170,
          ),
          MyElevatedButton(
            onPressed: onPhoneSubmit,
            text: 'Proceed',
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
