import 'package:chatsphere/presentation/helpers/database_service.dart';
import 'package:chatsphere/presentation/screens/landing/new_chat_find_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../helpers/auth_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;

  final GetIt getIt = GetIt.instance;
  late AuthService authService;
  late DatabaseService databaseService;

  @override
  void initState() {
    super.initState();
    authService = getIt.get<AuthService>();
    databaseService = getIt.get<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildUi(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 40.0,
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FindFriendsScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildUi() {
    final theme = Theme.of(context);
    return CustomScrollView(slivers: [
      SliverAppBar(
        backgroundColor: theme.colorScheme.background,
        title: const Text('Inbox'),
        floating:
            true, // AppBar hides when scrolling down and shows when scrolling up
        automaticallyImplyLeading: false,
        actions: [
          // Notification icon
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => authService.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (context, index) =>
      //         _buildUiItem(index), // Replace with your list builder
      //     childCount: _dataList.length, // Replace with your data list length
      //   ),
      // ),
    ]);
  }
}
