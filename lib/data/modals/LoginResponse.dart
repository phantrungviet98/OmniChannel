
class LoginResponse {
  LoginResponse({
    this.accessToken,
    this.userData,
    this.error,
  });

  String accessToken;
  UserData userData;
  LoginError error;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json["accessToken"],
        userData: json["userData"] != null ? UserData.fromJson(json["userData"]) : null,
        error: json["error"] != null ? LoginError.fromJson(json["error"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "userData": userData.toJson(),
        "error": error,
      };
}

class UserData {
  const UserData({
    this.displayName,
    this.email,
    this.username,
    this.userRole,
    this.isActive,
    this.dateCreated,
  });

  final String displayName;
  final String email;
  final String username;
  final String userRole;
  final bool isActive;
  final dynamic dateCreated;

  static const empty = UserData(
      displayName: '',
      email: '',
      username: '',
      userRole: '',
      isActive: false,
      dateCreated: null);

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        displayName: json["display_name"],
        email: json["email"],
        username: json["username"],
        userRole: json["user_role"],
        isActive: json["is_active"],
        dateCreated: json["date_created"],
      );

  Map<String, dynamic> toJson() => {
        "display_name": displayName,
        "email": email,
        "username": username,
        "user_role": userRole,
        "is_active": isActive,
        "date_created": dateCreated,
      };
}

class LoginError {
  String message;

  LoginError({this.message});

  LoginError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
