class CommentModel {
  late final String commentText;
  late final String postId;
  late final String userId;
  late final String userName;
  late final String profileImage;
  late final String dateTime;
  CommentModel(
      {required this.commentText,
      required this.dateTime,
      required this.postId,
      required this.profileImage,
      required this.userId,
      required this.userName});

  CommentModel.fromjson(Map<String, dynamic> data) {
    commentText = data["commentText"] ?? "";
    postId = data["postId"];
    userId = data["uid"] ?? "";
    userName = data["userName"] ?? "";
    profileImage = data["profileImage"] ?? "";
    dateTime = data["dateTime"] ?? DateTime.now().toString();
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data["commentText"] = commentText;
    data["dateTime"] = dateTime;
    data["postId"] = postId;
    data["profileImage"] = profileImage;
    data["userName"] = userName;
    data["uid"] = userId;

    return data;
  }
}
