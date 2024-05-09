import 'package:my_tech_lib/services/models/project_model.dart';

import '../../app/theme/tools.dart';

class WebProject extends Project {
  String urlWeb;
  String typeWeb;
  String frameworkUsed;
  String bddUsed;
  String hostingUsed;
  String securityUsed;

  WebProject({
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
    String? core_company,
    bool isPersonal = false,
    String? companyName,
    illustrationsUrl = const [],
    this.urlWeb = '',
    this.typeWeb = '',
    this.frameworkUsed = '',
    this.bddUsed = '',
    this.hostingUsed = '',
    this.securityUsed = '',
  }) : super(
          uuid: uuid,
          name: name,
          description: description,
          type: type,
          isPersonal: isPersonal,
          version: version,
          core_library: core_library,
          logoUrl: logoUrl,
          createdBy: createdBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          core_company: core_company,
          companyName: companyName,
          illustrationsUrl: illustrationsUrl,
        );

  factory WebProject.fromJson(Map<String, dynamic> json) {
    return WebProject(
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
          json['illustrations_url'] != null && json['illustrations_url'].toString().isNotEmpty  ? json['illustrations_url'].toString().split(',') : [],
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
      json['updated_at']  != null ?  DateTime.parse(json['updated_at']) : null,
      urlWeb: json['url_web'] ?? '',
      typeWeb: json['type_web'] ?? '',
      frameworkUsed: json['framework_used'] ?? '',
      bddUsed: json['bdd_used'] ?? '',
      hostingUsed: json['hosting_used'] ?? '',
      securityUsed: json['security_used'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['url_web'] = urlWeb;
    json['type_web'] = typeWeb;
    json['framework_used'] = frameworkUsed;
    json['bdd_used'] = bddUsed;
    json['hosting_used'] = hostingUsed;
    json['security_used'] = securityUsed;
    return json;
  }
}
