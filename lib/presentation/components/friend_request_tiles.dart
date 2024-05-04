import 'package:flutter/material.dart';

import '../../config/model/friend_requests.dart';

class FriendRequestTile extends StatelessWidget {
  final FriendRequest friendRequest;
  const FriendRequestTile({super.key, required this.friendRequest,});

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   dense: false,
    //   leading: CircleAvatar(
    //     backgroundImage: AssetImage(
    //       userProfile.pfpUrl!.toString(),
    //     ),
    //   ),
    //   title: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(
    //         userProfile.userName!,
    //       ),
    //       TextButton.icon(
    //         onPressed: onTap,
    //         icon: Icon(icon),
    //         label: Text(text),
    //         style: TextButton.styleFrom(
    //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return const Placeholder();
  }
}