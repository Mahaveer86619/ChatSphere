import 'package:chatsphere/presentation/helpers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = false;

  final GetIt getIt = GetIt.instance;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = getIt.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.background,
          title: Text(
            'ChatSphere',
            style: TextStyle(
              color: theme.colorScheme.onBackground,
            ),
          ),
          actions: [
            // Profile icon
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: IconButton(
                  onPressed: () {
                    authService.signOut();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 22.0,
            right: 22.0,
          ),
          child: _buildUi(),
        ),
      ),
    );
  }

  Widget _buildUi() {
    return const Placeholder();
  }
}
