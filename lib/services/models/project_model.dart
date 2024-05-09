import 'package:my_tech_lib/services/models/library_model.dart';

import '../../app/theme/tools.dart';

class Project {
  final String uuid;
 String name;
   String description;
  final String type;
  final String? core_company;
  final String? companyName;
  final String core_library;
   Library? library;
  final String version;
  final String logoUrl;
   List<dynamic> illustrationsUrl;
  final String createdBy;
  final String createdAt;
  final DateTime? updatedAt;
   bool isPersonal;

  Project({
    this.uuid = '-1',
    this.name = '',
    this.description = '',
    this.type = '',
    this.core_company = '',
    this.illustrationsUrl = const [],
    this.companyName = '',
    this.core_library = '',
    this.logoUrl = '',
    this.version = 'V1.0.0',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = null,
    this.isPersonal = false,
    this.library,
  });

  factory Project.fromJson(Map<String, dynamic> json) {

    return Project(
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
      illustrationsUrl: json['illustrations_url'] != null && json['illustrations_url'].toString().isNotEmpty
          ? json['illustrations_url'].toString().split(',')
          : [],
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
      json['updated_at']  != null ?  DateTime.parse(json['updated_at']) : null,
    );
  }

  factory Project.fromJsonInformation(Map<String, dynamic> json) {
    return Project(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      version: json['version'] ?? 'V?.?.?',
    );
  }

  Map<String, dynamic> toJson() {
    var json = {
      'name': name,
      'type': type,
      'is_personal': isPersonal,
      'description': description,
      'core_company': core_company,
      'core_library': core_library,
      'version': version,
    };
    String illustrations = '';
    for(int i = 0, len = illustrationsUrl.length; i < len; i++) {
      illustrations += illustrationsUrl[i];
      if (i < len - 1) {
        illustrations += ',';
      }
    }
    json['illustrations_url'] = illustrations;
    return json;
  }
}
