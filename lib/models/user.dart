class User {
  User({
    this.id,
    this.roleId,
    this.username,
    this.noHandphone,
    this.email,
    this.emailVerifiedAt,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.tokenType,
  });

  String? id;
  String? roleId;
  String? username;
  String? noHandphone;
  String? email;
  String? emailVerifiedAt;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? accessToken;
  String? tokenType;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        roleId: json["role_id"].toString(),
        username: json["username"].toString(),
        noHandphone: json["no_handphone"].toString(),
        email: json["email"].toString(),
        emailVerifiedAt: json["email_verified_at"].toString(),
        isActive: json["is_active"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        accessToken: json["access_token"].toString(),
        tokenType: json["token_type"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "username": username,
        "no_handphone": noHandphone,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
