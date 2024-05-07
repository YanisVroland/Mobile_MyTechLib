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
  final String logoUrl;

  Company({
    this.uuid = '-1',
    this.name = '',
    this.description = '',
    this.code = '',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.logoUrl = '',
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      code: json['code'] ?? '',
      logoUrl: json['logo_url'] ?? '',
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
