// ignore_for_file: use_build_context_synchronously

import 'package:chatsphere/config/constants.dart';
import 'package:chatsphere/config/model/user_profile.dart';
import 'package:chatsphere/presentation/components/loading.dart';
import 'package:chatsphere/presentation/helpers/auth_gate.dart';
import 'package:chatsphere/presentation/helpers/auth_service.dart';
import 'package:chatsphere/presentation/helpers/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/elevated_btn.dart';
import '../../components/text_field.dart';

class CompleteAuthScreen extends StatefulWidget {
  final String authMethod;
  const CompleteAuthScreen({
    super.key,
    required this.authMethod,
  });

  @override
  State<CompleteAuthScreen> createState() => _CompleteAuthScreenState();
}

class _CompleteAuthScreenState extends State<CompleteAuthScreen> {
  bool isLoading = false;
  String? selectedAvatarPath;

  final GetIt getIt = GetIt.instance;
  late AuthService authService;
  late DatabaseService databaseService;

  final usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authService = getIt.get<AuthService>();
    databaseService = getIt.get<DatabaseService>();
  }

  void onCompleteAuth() async {
    try {
      setState(() {
        isLoading = true;
      });

      final result = await databaseService.createUserProfile(
        UserProfile(
          uid: authService.user!.uid,
          userName: usernameController.text.trim(),
          pfpUrl: selectedAvatarPath,
        ),
      );
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isLoading)
                  const Center(
                    child: LoadingWidget(text: "Completing Authentication..."),
                  ),
                if (!isLoading) _buildUi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatarSelection() {
    final List<String> avatars = avatarList;
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      shrinkWrap: true, // Wrap content height
      crossAxisCount: 5,
      children: avatars.map((avatar) => _buildAvatarItem(avatar)).toList(),
    );
  }

  Widget _buildAvatarItem(String avatar) {
    final theme = Theme.of(context);
    final isSelected = avatar == selectedAvatarPath;
    final border = isSelected
        ? Border.all(color: theme.colorScheme.primary, width: 2)
        : null;

    return GestureDetector(
      onTap: () => setState(() => selectedAvatarPath = avatar),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: border,
          image: DecorationImage(
            image: AssetImage(avatar),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) => debugPrint(
                'Error loading avatar: $avatar'), // Handle error (optional)
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
          // Text
          Text(
            "Create Your Profile.",
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            'This will be displayed to other users!',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          // Username Field
          const SizedBox(
            height: 32,
          ),
          Text(
            'Create your username',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          MyTextField(
            hintText: 'Enter Username',
            controller: usernameController,
            keyboardType: TextInputType.name,
            label: 'Username',
            keyboardAction: TextInputAction.done,
          ),
          // Avatar selection
          const SizedBox(
            height: 32,
          ),
          Text(
            'Choose your avatar',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          _avatarSelection(),
          // Submit button
          const SizedBox(
            height: 32,
          ),
          MyElevatedButton(
            onPressed: onCompleteAuth,
            text: 'Create Profile',
            mheight: 40,
          )
        ],
      ),
    );
  }
}
