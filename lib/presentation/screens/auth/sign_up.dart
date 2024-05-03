// ignore_for_file: use_build_context_synchronously

import 'package:chatsphere/presentation/components/aternative_auth_card.dart';
import 'package:chatsphere/presentation/components/elevated_btn.dart';
import 'package:chatsphere/presentation/components/loading.dart';
import 'package:chatsphere/presentation/components/text_field.dart';
import 'package:chatsphere/presentation/helpers/auth_gate.dart';
import 'package:chatsphere/presentation/helpers/auth_service.dart';
import 'package:chatsphere/presentation/helpers/database_service.dart';
import 'package:chatsphere/presentation/helpers/storage_service.dart';
import 'package:chatsphere/presentation/screens/auth/complete_auth.dart';
import 'package:chatsphere/presentation/screens/auth/phone_auth.dart';
import 'package:chatsphere/presentation/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;

  final GetIt getIt = GetIt.instance;
  late AuthService authService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  void onSignUp() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await authService.emailSignUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (result) {
        // uploadAndSaveUserProfile(uid: authService.user!.uid);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CompleteAuthScreen(authMethod: 'Email',)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error, ${e.toString()}",
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
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

  // Future<String?> uploadAndSaveUserProfile({
  //   required String uid,
  // }) async {
  //   final randomAvatar = getRandomAvatar();
  //   final pfpUrl = await storageService.uploadAvatarAndGetUrl(
  //     assetPath: randomAvatar,
  //   );
  //   if (pfpUrl != null) {
  //     await databaseService.createUserProfile(
  //       userProfile: UserProfile(
  //         uid: uid,
  //         pfpUrl: pfpUrl,
  //       ),
  //     );
  //     return pfpUrl;
  //   } else {
  //     return null;
  //   }
  // }

  void onChangeSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
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
          MaterialPageRoute(builder: (context) => const CompleteAuthScreen(authMethod: 'Google',)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error, ${e.toString()}",
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
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

  @override
  void initState() {
    super.initState();
    authService = getIt.get<AuthService>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLoading)
                  const Center(
                    child: LoadingWidget(text: "Signing Up..."),
                  ),
                if (!isLoading) _buildUi(),
              ],
            ),
          ),
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
          Text(
            'Create Account',
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            'Connect with your friends!',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          // TextFields
          const SizedBox(
            height: 40,
          ),
          MyTextField(
            hintText: 'Email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
            keyboardAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 16,
          ),
          MyPasswordField(
            hintText: 'Password',
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            label: 'Password',
            keyboardAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 16,
          ),
          MyPasswordField(
            hintText: 'Re-enter Password',
            controller: rePasswordController,
            keyboardType: TextInputType.visiblePassword,
            label: 'Re-enter Password',
            keyboardAction: TextInputAction.done,
          ),
          // Elevated btn
          const SizedBox(
            height: 50,
          ),
          MyElevatedButton(
            onPressed: () => {
              if (passwordController.text == rePasswordController.text)
                onSignUp()
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Error, passwords don't match",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                }
            },
            text: 'Sign Up',
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
                'or sign up with',
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
              Navigator.push(
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
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: AlternateAuthCard(
                  asset: Icons.phone,
                  text: "Phone Number",
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
              child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: AlternateGoogleAuthCard(
                    text: "Google Account",
                  )),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: onChangeSignIn,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Sign In!',
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
