class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String userType; // user | driver
  final String governorate;
  final String imageUrl;
  // nullable لو مستخدم عادي

  UserModel({
    required this.password,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    required this.governorate,
    required this.imageUrl,

  });

  /// 🔹 من Firestore → Dart Object
  factory UserModel.fromJson(Map<String, dynamic> json, String docId) {
    return UserModel(
      id: docId,
      password: json['password'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      userType: json['userType'],
      governorate: json['governorate'],
      imageUrl: json['imageUrl'],
      
    );
  }

  /// 🔹 من Dart Object → Firestore
  Map<String, dynamic> toJson() {
    return {
      'password':password,
      'name': name,
      'email': email,
      'phone': phone,
      'userType': userType,
      'governorate': governorate,
      'imageUrl': imageUrl,
     
      'createdAt': DateTime.now(),
    };
  }
}
