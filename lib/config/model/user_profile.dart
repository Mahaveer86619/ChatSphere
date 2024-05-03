class UserProfile {
  String? uid;
  String? userName;
  String? pfpUrl;

  UserProfile({
    required this.uid,
    required this.userName,
    required this.pfpUrl,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['userName'];
    pfpUrl = json['pfpUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['uid'] = uid;
    data['userName'] = userName;
    data['pfpUrl'] = pfpUrl;

    return data;
  }
}
