

class DriverModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String governorate;

  final String profileImage;
  final String carImage;

  final double rating;
  final int totalTrips;
  final bool isOnline;
  final String userType;

  final double lat;
  final double lng;
  final String password;

  DriverModel({
    required this.id,
    required this.userType,
    required this.name,
    required this.email,
    required this.phone,
    required this.governorate,
    required this.profileImage,
    required this.carImage,
    required this.rating,
    required this.totalTrips,
    required this.isOnline,
    required this.lat,
    required this.lng,
    required this.password,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json, String id) {
    return DriverModel(
      id: id,
      userType:json['userType'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      governorate: json['governorate'] ?? '',
      profileImage: json['profileImage'] ?? '',
      carImage: json['carImage'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      totalTrips: json['totalTrips'] ?? 0,
      isOnline: json['isOnline'] ?? false,
      lat: (json['currentLocation']?['lat'] ?? 0).toDouble(),
      lng: (json['currentLocation']?['lng'] ?? 0).toDouble(),
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userType': userType,
      'email': email,
      'phone': phone,
      'governorate': governorate,
      'profileImage': profileImage,
      'carImage': carImage,
      'rating': rating,
      'totalTrips': totalTrips,
      'isOnline': isOnline,
      'currentLocation': {
        'lat': lat,
        'lng': lng,
      },
      'password': password,
    };
  }
}
