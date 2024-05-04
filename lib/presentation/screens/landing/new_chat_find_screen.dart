import 'package:chatsphere/config/model/friend_requests.dart';
import 'package:chatsphere/config/model/user_profile.dart';
import 'package:chatsphere/presentation/components/loading.dart';
import 'package:chatsphere/presentation/components/users_tiles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../helpers/auth_service.dart';
import '../../helpers/database_service.dart';

class FindFriendsScreen extends StatefulWidget {
  const FindFriendsScreen({super.key});

  @override
  State<FindFriendsScreen> createState() => _FindFriendsScreenState();
}

class _FindFriendsScreenState extends State<FindFriendsScreen> {
  bool isLoading = false;
  bool hasSentRequest = false;

  final GetIt getIt = GetIt.instance;
  late AuthService authService;
  late DatabaseService databaseService;

  // String text = 'Invite';
  // IconData icon = Icons.add;

  @override
  void initState() {
    super.initState();
    authService = getIt.get<AuthService>();
    databaseService = getIt.get<DatabaseService>();
  }

  void onInvite(String recieverId) {
    try {
      setState(() {
        isLoading = true;
      });
      databaseService.sendFriendRequest(
        FriendRequest(
          requestId: authService.user!.uid + recieverId,
          senderId: authService.user!.uid,
          recieverId: recieverId,
          status: "pending",
        ),
      );
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

  // Future<void> hasSentFriendRequest(String uid) async {
  //   bool result = await databaseService.hasSentFriendRequest(uid);
  //   if (result) {
  //     setState(() {
  //       text = 'Pending';
  //       icon = Icons.check;
  //     });
  //   } else {
  //     setState(() {
  //       text = 'Invite';
  //       icon = Icons.add;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildUi(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Find Friends'),
          actions: [
            // Search
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            // Menu
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUi() {
    return StreamBuilder(
      stream: databaseService.getAllUserProfiles(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.hasData && snapshot.data != null) {
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemBuilder: (context, index) {
              UserProfile user = users[index].data();
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: UserTile(
                  userProfile: user,
                  onTap: () => onInvite(user.uid!),
                  text: "Invite",
                  icon: Icons.add,
                ),
              );
            },
            itemCount: users.length,
          );
        }
        return const Center(child: LoadingWidget(text: "Loading..."));
      },
    );
  }
}
