class UserModel {
  late String uuid;
  late String email;
  late String name;
  late String lastname;
  late String password;
  late String access_token;
  late String refresh_token;

  UserModel({
    this.uuid = '',
    this.email = '',
    this.name = '',
    this.lastname = '',
    this.password = '',
    this.access_token = '',
    this.refresh_token = '',
  });

  UserModel.fromJson(map)
      : uuid = map["uuid"] ?? "",
        email = map["email"] ?? "",
        name = map["name"] ?? "",
        lastname = map["lastname"] ?? "",
        access_token = map["access_token"] ?? "",
        refresh_token = map["refresh_token"] ?? "";
}
