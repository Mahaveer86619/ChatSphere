import 'package:chatsphere/presentation/components/elevated_btn.dart';
import 'package:chatsphere/presentation/components/outlined_btn.dart';
import 'package:chatsphere/presentation/screens/auth/sign_in.dart';
import 'package:chatsphere/presentation/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lets Get Started!',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 28,
          ),
        ),
        // Text: Get in touch with ease.
        Text(
          'Get in touch with ease.',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        // Button: Sign In
        MyElevatedButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            )
          },
          text: 'Sign In',
          mheight: 60,
        ),
        // Button: Sign Up
        const SizedBox(
          height: 8,
        ),
        MyOutlinedButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            )
          },
          text: 'Sign Up',
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
