import 'package:chatsphere/config/model/user_profile.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final UserProfile userProfile;
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  const UserTile({
    super.key,
    required this.userProfile,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          userProfile.pfpUrl!.toString(),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            userProfile.userName!,
          ),
          TextButton.icon(
            onPressed: onTap,
            icon: Icon(icon),
            label: Text(text),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
