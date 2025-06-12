class Tag {
  final String id, name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(dynamic data) {
    return Tag(id: data["_id"], name: data["name"]);
  }
}
