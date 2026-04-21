class PostModel {
  final String id;
  final String? userId;
  final String? username;
  final String? userAvatar;
  final String? companyName;
  final String? companyLogo;
  final String? image;
  final String? caption;
  final String? location;
  int likes;
  int commentsCount;
  final String? timestamp;
  bool liked;
  bool isSaved;

  PostModel({
    required this.id,
    this.userId,
    this.username,
    this.userAvatar,
    this.companyName,
    this.companyLogo,
    this.image,
    this.caption,
    this.location,
    this.likes = 0,
    this.commentsCount = 0,
    this.timestamp,
    this.liked = false,
    this.isSaved = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    var user = json['userId'];
    String? uName;
    String? uAvatar;
    String? cName;
    String? cLogo;
    String? uId;

    if (user is Map) {
      uName = user['fullName'];
      uAvatar = user['profilePic'] ?? user['profilePhoto'];
      cName = user['companyName'];
      cLogo = user['companyLogo'];
      uId = user['_id']?.toString();
    } else {
      uId = user?.toString();
    }

    String img = json['image'] ?? '';
    if (img.isNotEmpty && !img.startsWith('http')) {
      img = "https://waaro.in${img.startsWith('/') ? '' : '/'}$img";
    }

    return PostModel(
      id: json['_id'] ?? json['id'] ?? '',
      userId: uId,
      username: uName ?? "user",
      userAvatar: uAvatar,
      companyName: cName,
      companyLogo: cLogo,
      image: img,
      caption: json['description'] ?? '',
      location: json['location'] ?? '',
      likes: json['totalLikes'] ?? (json['likes'] is List ? json['likes'].length : 0),
      commentsCount: json['commentsCount'] ?? (json['comments'] is List ? json['comments'].length : 0),
      timestamp: json['createdAt'], // Will need formatting
      liked: json['liked'] ?? false,
      isSaved: json['isSaved'] ?? false,
    );
  }
}
