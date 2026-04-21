class ApiConstants {
  static const String baseUrl = "https://waaro.in/api";
  static const String socketUrl = "https://waaro.in";

  // Auth
  static const String signin = "/signin";
  static const String profile = "/profile";
  static const String signup = "/signup"; // Though no registration screen, keeping for completeness if needed internally

  // Products & Posts
  static const String filterProducts = "/filter-products";
  static const String allCities = "/all-cities";
  static const String getPosts = "/getPosts"; // Format: /{userId}/getPosts
  static const String likePost = "/like"; // Format: /{postId}/like
  static const String comments = "/comments"; // Format: /{postId}/comments
  static const String comment = "/comment"; // Format: /{postId}/comment
  static const String savePost = "/save"; // Format: /{postId}/save
  static const String connect = "/connect"; // Format: /user/{postUserId}/connect

  // Creation
  static const String createProduct = "/create-product";
  static const String createPost = "/create-post";
  static const String upload = "/upload";
  static const String categories = "/categories";
  static const String category = "/category";
  static const String userSubcategories = "/user-subcategories";
  static const String userSubcategory = "/user-subcategory";

  // Inquiries & Leads
  static const String inquiries = "/inquiries";
  static const String leads = "/leads";
  static const String messages = "/messages";
  static const String conversation = "/messages/conversation";
  static const String markAsRead = "/messages/mark-as-read";

  // Profile Update
  static const String updateUser = "/update-user";
  static const String completeProfile = "/complete-profile";
}
