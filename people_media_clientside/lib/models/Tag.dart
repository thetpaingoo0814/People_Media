// This code is create by M23W7502_ThetPaingOo
class Tag {
  final String id, name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(dynamic data) {
    return Tag(id: data["_id"], name: data["name"]);
  }
}
