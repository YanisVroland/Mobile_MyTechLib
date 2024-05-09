import 'package:my_tech_lib/services/models/project_model.dart';

import '../../app/theme/tools.dart';

class ApiProject extends Project {
   String typeApi;
   String dataFormat;
   String frameworkUsed;
   String authUsed;
   String documentationUrl;

  ApiProject({
    String uuid = '-1',
    String name = '',
    String description = '',
    String type = '',
    String version = 'V1.0.0',
    String core_library = '',
    String logoUrl = '',
    String createdBy = '',
    String createdAt = '',
     DateTime? updatedAt = null,
    bool isPersonal = false,
    String? core_company,
    String? companyName,
    List<String> illustrationsUrl = const [],
    this.typeApi = '',
    this.dataFormat = '',
    this.frameworkUsed = '',
    this.authUsed = '',
    this.documentationUrl = '',
  }) : super(
          uuid: uuid,
          name: name,
          description: description,
          type: type,
          version: version,
    isPersonal: isPersonal,
          core_library: core_library,
          logoUrl: logoUrl,
          createdBy: createdBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          core_company: core_company,
          companyName: companyName,
          illustrationsUrl: illustrationsUrl,
        );

  factory ApiProject.fromJson(Map<String, dynamic> json) {
    return ApiProject(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      version: json['version'] ?? 'V?.?.?',
      isPersonal: json['is_personal'] ?? false,
      core_company: json['core_company'] != null ? json['core_company']['uuid'] : null,
      companyName: json['core_company'] != null ? json['core_company']['name'] : null,
      core_library: json['core_library'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      illustrationsUrl:
          json['illustrations_url'] != null && json['illustrations_url'].toString().isNotEmpty ? json['illustrations_url'].toString().split(',') : [],
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
      json['updated_at']  != null ?  DateTime.parse(json['updated_at']) : null,
      typeApi: json['type_api'] ?? '',
      dataFormat: json['data_format'] ?? '',
      frameworkUsed: json['framework_used'] ?? '',
      authUsed: json['auth_used'] ?? '',
      documentationUrl: json['documentation_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['type_api'] = typeApi;
    json['data_format'] = dataFormat;
    json['framework_used'] = frameworkUsed;
    json['auth_used'] = authUsed;
    json['documentation_url'] = documentationUrl;
    return json;
  }
}
