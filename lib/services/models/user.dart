
class UserData {
  late String uuid;
  late String email;
  late String login;
  late String pwd;
  late bool active_token;
  late String token_device;

  UserData(
      {this.uuid = "",
      required this.email,
      required this.pwd,
      this.token_device = '',
      this.login = "",
      this.active_token = false});

  UserData.fromJson(map)
      : uuid = map["uuid"],
        login = map["login"],
        email = map["email"];
}
