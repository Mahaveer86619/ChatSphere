import 'dart:math';

List<String> avatarList = [
  'assets/avatars/avatar1.png',
  'assets/avatars/avatar2.png',
  'assets/avatars/avatar3.png',
  'assets/avatars/avatar4.png',
  'assets/avatars/avatar5.png',
  'assets/avatars/avatar6.png',
  'assets/avatars/avatar7.png',
  'assets/avatars/avatar8.png',
  'assets/avatars/avatar9.png',
  'assets/avatars/avatar10.png',
  'assets/avatars/avatar11.png',
  'assets/avatars/avatar12.png',
  'assets/avatars/avatar13.png',
  'assets/avatars/avatar14.png',
  'assets/avatars/avatar15.png',
  'assets/avatars/avatar16.png',
  'assets/avatars/avatar17.png',
  'assets/avatars/avatar18.png',
  'assets/avatars/avatar19.png',
  'assets/avatars/avatar20.png',
  'assets/avatars/avatar21.png',
  'assets/avatars/avatar22.png',
  'assets/avatars/avatar23.png',
  'assets/avatars/avatar24.png',
];

String getRandomAvatar() {
  final random = Random();
  final index = random.nextInt(avatarList.length) + 1;
  return avatarList[index];
}
