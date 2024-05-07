import 'dart:math';

import '../../app/theme/tools.dart';

class Company {
  final String uuid;
  String name;
  String description;
  String code;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  String logoUrl;
  int projectCpt;
  int libraryCpt;

  Company({
    this.uuid = '-1',
    this.name = '',
    this.description = '',
    this.code = '',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.logoUrl = '',
    this.projectCpt = 0,
    this.libraryCpt = 0,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      code: json['code'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      projectCpt: json['stats'] != null ? json['stats']['projectCpt'] : 0,
      libraryCpt: json['stats'] != null ? json['stats']['libraryCpt'] : 0,
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
          json['updated_at'] != null ? Tools.formatDate(DateTime.parse(json['updated_at'])) : '',
    );
  }

  factory Company.fromJsonUpdate(Map<String, dynamic> json) {
    return Company(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      code: json['code'] ?? '',
      logoUrl: json['logo_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
