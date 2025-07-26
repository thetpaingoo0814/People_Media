// This code is create by M23W7502_ThetPaingOo
class Comment {
  String id, postId, user, content, image, status;
  DateTime created;

  Comment({
    required this.id,
    required this.postId,
    required this.user,
    required this.content,
    required this.image,
    required this.status,
    required this.created,
  });

  factory Comment.fromJson(dynamic data) {
    return Comment(
      id: data["_id"],
      postId: data["postId"],
      user: data["user"]["name"],
      content: data["content"],
      image: data["image"],
      status: data["status"],
      created: DateTime.parse(data["created"] as String),
    );
  }
}
