import 'package:chatsphere/presentation/components/elevated_btn.dart';
import 'package:chatsphere/presentation/components/text_field.dart';
import 'package:chatsphere/presentation/screens/auth/phone_auth.dart';
import 'package:chatsphere/presentation/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onSignIn() {}
  void onChangeSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
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
          const SizedBox(
            height: 30,
          ),
          // Text
          Text(
            'Hi, Welcome back!',
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            'Hello again, you have been missed.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          // TextFields
          const SizedBox(
            height: 85,
          ),
          MyTextField(
            hintText: 'Email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
          ),
          const SizedBox(
            height: 16,
          ),
          MyPasswordField(
            hintText: 'Password',
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            label: 'Password',
          ),
          // Elevated btn
          const SizedBox(
            height: 85,
          ),
          MyElevatedButton(
            onPressed: onSignIn,
            text: 'Sign In',
            mheight: 40,
          ),
          // or
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
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhoneAuthScreen(),
                  ))
            },
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
                      Icons.phone,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    // Text
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'phone number',
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
          Container(
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
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: onChangeSignUp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Sign Up!',
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
