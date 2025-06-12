class Vary {
  static String token = "";
  static var header = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
  static dynamic msg = "";
}
