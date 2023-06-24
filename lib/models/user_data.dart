class UserData {
  String uid;
  String name;
  String phoneNumber;

  UserData({
    required this.name,
    required this.uid,
    required this.phoneNumber
  });

  UserData.fromMap(Map<String, dynamic> map)
      : name = map['name'] ?? "",
        uid = map['uid'] ?? "",
        phoneNumber = map['phoneNumber'] ?? "";

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
