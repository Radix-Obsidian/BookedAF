enum UserRole { customer, beautyProfessional }

class UserProfile {
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;
  final UserRole role;
  final BusinessProfile? businessProfile;
  final CustomerProfile? customerProfile;

  UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
    required this.role,
    this.businessProfile,
    this.customerProfile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      photoURL: json['photoURL'],
      role: UserRole.values.firstWhere(
        (e) => e.toString() == json['role'],
        orElse: () => UserRole.customer,
      ),
      businessProfile: json['businessProfile'] != null
          ? BusinessProfile.fromJson(json['businessProfile'])
          : null,
      customerProfile: json['customerProfile'] != null
          ? CustomerProfile.fromJson(json['customerProfile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'role': role.toString(),
      'businessProfile': businessProfile?.toJson(),
      'customerProfile': customerProfile?.toJson(),
    };
  }
}

class BusinessProfile {
  final String businessName;
  final String bio;
  final String phoneNumber;
  final Address serviceAddress;
  final List<String> serviceCategories;
  final bool isVerified;
  final DateTime createdAt;

  BusinessProfile({
    required this.businessName,
    required this.bio,
    required this.phoneNumber,
    required this.serviceAddress,
    required this.serviceCategories,
    this.isVerified = false,
    required this.createdAt,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      businessName: json['businessName'] ?? '',
      bio: json['bio'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      serviceAddress: Address.fromJson(json['serviceAddress'] ?? {}),
      serviceCategories: List<String>.from(json['serviceCategories'] ?? []),
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessName': businessName,
      'bio': bio,
      'phoneNumber': phoneNumber,
      'serviceAddress': serviceAddress.toJson(),
      'serviceCategories': serviceCategories,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class CustomerProfile {
  final String? phoneNumber;
  final Address? preferredAddress;
  final List<String> favoriteServices;
  final DateTime createdAt;

  CustomerProfile({
    this.phoneNumber,
    this.preferredAddress,
    required this.favoriteServices,
    required this.createdAt,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      phoneNumber: json['phoneNumber'],
      preferredAddress: json['preferredAddress'] != null
          ? Address.fromJson(json['preferredAddress'])
          : null,
      favoriteServices: List<String>.from(json['favoriteServices'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'preferredAddress': preferredAddress?.toJson(),
      'favoriteServices': favoriteServices,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final double? latitude;
  final double? longitude;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String get fullAddress {
    return '$street, $city, $state $postalCode, $country';
  }
}