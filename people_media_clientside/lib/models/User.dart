// This code is create by M23W7502_ThetPaingOo
class User {
  String id, name, phone, displayName, profile;
  int role;
  DateTime created;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.displayName,
    required this.role,
    required this.profile,
    required this.created,
  });

  factory User.fromJson(dynamic data) {
    return User(
      id: data["_id"],
      name: data["name"],
      phone: data["phone"],
      displayName: data["displayName"],
      role: data["role"],
      profile: data["profile"],
      created: DateTime.parse(data["created"]),
    );
  }
}
