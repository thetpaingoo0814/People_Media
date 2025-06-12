class Cat {
  final String id, name, desc, image;

  Cat({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      desc: json["desc"] ?? '',
      image: json["image"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "name": name, "desc": desc, "image": image};
  }
}
