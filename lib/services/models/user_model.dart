class UserModel {
  late String uuid;
  late String email;
  late String name;
  late String lastname;
  late String password;
  late String companyUuid;

  UserModel({
    this.uuid = '',
    this.email = '',
    this.name = '',
    this.lastname = '',
    this.password = '',
    this.companyUuid = '',
  });

  UserModel.fromJson(map)
      : uuid = map["uuid"] ?? "",
        email = map["email"] ?? "",
        name = map["name"] ?? "",
        lastname = map["lastName"] ?? "",
        companyUuid = map["core_company"] ?? "";


}
