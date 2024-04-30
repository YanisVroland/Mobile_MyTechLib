import 'package:my_tech_lib/services/models/project_model.dart';

import '../../app/theme/tools.dart';

class MobileProject extends Project {
  final String platform;
  final String versionOS;
  final String frameworkUsed;

  MobileProject({
    String uuid = '-1',
    String name = '',
    String description = '',
    String type = '',
    String version = 'V1.0.0',
    String core_library = '',
    String logoUrl = '',
    String createdBy = '',
    String createdAt = '',
    String updatedAt = '',
    String? core_company,
    String? companyName,
    List<String> illustrationsUrl = const [],
    this.platform = '',
    this.versionOS = '',
    this.frameworkUsed = '',
  }) : super(
          uuid: uuid,
          name: name,
          description: description,
          type: type,
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

  factory MobileProject.fromJson(Map<String, dynamic> json) {
    return MobileProject(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      version: json['version'] ?? 'V?.?.?',
      core_company: json['core_company'] != null ? json['core_company']['uuid'] : null,
      companyName: json['core_company'] != null ? json['core_company']['name'] : null,
      core_library: json['core_library'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      illustrationsUrl:
          json['illustrations_url'] != null ? json['illustrations_url'].toString().split(',') : [],
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
          json['updated_at'] != null ? Tools.formatDate(DateTime.parse(json['updated_at'])) : '',
      platform: json['platform'] ?? '',
      versionOS: json['version_os'] ?? '',
      frameworkUsed: json['framework_used'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['platform'] = platform;
    json['version_os'] = versionOS;
    json['framework_used'] = frameworkUsed;
    return json;
  }
}
