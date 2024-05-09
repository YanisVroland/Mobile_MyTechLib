class UserModel {
  late String uuid;
  late String email;
  late String name;
  late String lastname;
  late String password;
  late String companyUuid;
  late String profileUrl;
  late bool companyAdmin;

  UserModel({
    this.uuid = '',
    this.email = '',
    this.name = '',
    this.lastname = '',
    this.password = '',
    this.profileUrl = '',
    this.companyUuid = '',
    this.companyAdmin = false,
  });

  UserModel.fromJson(map)
      : uuid = map["uuid"] ?? "",
        email = map["email"] ?? "",
        name = map["name"] ?? "",
        lastname = map["lastName"] ?? "",
        companyAdmin = map["company_admin"] ?? "",
        companyUuid = map["core_company"] ?? "",
        profileUrl = map["profile_url"] ?? "";

  Map<String, dynamic> toJson() {
    return {
      "email": email.trim(),
      "name": name.trim(),
      "lastname": lastname.trim(),
      "password": password.trim(),
    };
  }
}
