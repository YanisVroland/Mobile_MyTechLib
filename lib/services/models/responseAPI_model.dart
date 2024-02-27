import 'dart:convert';

class ResponseApi {
  late int status;
  late var body;

  ResponseApi({
    this.status = 400,
    this.body = "",
  });

  ResponseApi.fromRequest(var response)
      : status = response.statusCode ?? 400,
        body = response.body != "" ?jsonDecode(response.body) : "";
}
