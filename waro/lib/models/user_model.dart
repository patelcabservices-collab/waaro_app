class UserModel {
  final String id;
  final String? fullName;
  final String? email;
  final String? mobileNumber;
  final String? role;
  final String? profilePic;
  final String? companyName;
  final String? companyLogo;
  final bool? profileCompleted;
  final String? bannerImage;
  final String? city;
  final String? state;

  UserModel({
    required this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.role,
    this.profilePic,
    this.companyName,
    this.companyLogo,
    this.profileCompleted,
    this.bannerImage,
    this.city,
    this.state,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle nested user object if present
    final user = json['user'] ?? json;
    return UserModel(
      id: user['_id'] ?? user['id'] ?? '',
      fullName: user['fullName'],
      email: user['email'],
      mobileNumber: user['mobileNumber'] ?? user['mobile'],
      role: user['role'],
      profilePic: user['profilePic'] ?? user['profilePhoto'],
      companyName: user['companyName'],
      companyLogo: user['companyLogo'],
      profileCompleted: user['profileCompleted'] == true || user['profileCompleted'] == "true",
      bannerImage: user['bannerImage'],
      city: user['city'],
      state: user['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'mobileNumber': mobileNumber,
      'role': role,
      'profilePic': profilePic,
      'companyName': companyName,
      'companyLogo': companyLogo,
      'profileCompleted': profileCompleted,
      'bannerImage': bannerImage,
      'city': city,
      'state': state,
    };
  }
}
