class Post {
  final String id, title, content, category, tag, author;
  List<String> images;
  int likes, views;
  DateTime created;
  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.tag,
    required this.author,
    required this.images,
    required this.likes,
    required this.views,
    required this.created,
  });

  factory Post.fromJson(dynamic data) {
    return Post(
      id: data["_id"] ?? '',
      title: data["title"] ?? '',
      content: data["content"] ?? '',
      category: data["category"] ?? '',
      tag: data["tag"] ?? '',
      author: data["author"]["name"] ?? '',
      images:
          (data["images"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      likes: data["likes"] ?? 0,
      views: data["views"] ?? 0,
      created: DateTime.tryParse(data["created"] ?? '') ?? DateTime.now(),
    );
  }
}

