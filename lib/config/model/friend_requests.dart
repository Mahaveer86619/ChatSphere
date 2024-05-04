class FriendRequest {
  String? requestId;
  String? senderId;
  String? recieverId;
  String? status;

  FriendRequest({
    required this.requestId,
    required this.senderId,
    required this.recieverId,
    required this.status,
  });

  FriendRequest.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    senderId = json['senderId'];
    recieverId = json['recieverId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['requestId'] = requestId;
    data['senderId'] = senderId;
    data['recieverId'] = recieverId;
    data['status'] = status;

    return data;
  }
}
