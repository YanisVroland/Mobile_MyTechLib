class UserModel {
  late String uuid;
  late String email;
  late String name;
  late String lastname;
  late String password;
  late String companyUuid;
  late String profile_url;

  UserModel({
    this.uuid = '',
    this.email = '',
    this.name = '',
    this.lastname = '',
    this.password = '',
    this.profile_url = '',
    this.companyUuid = '',
  });

  UserModel.fromJson(map)
      : uuid = map["uuid"] ?? "",
        email = map["email"] ?? "",
        name = map["name"] ?? "",
        lastname = map["lastName"] ?? "",
        companyUuid = map["core_company"] ?? "",
        profile_url = map["profile_url"] ?? "";
}
