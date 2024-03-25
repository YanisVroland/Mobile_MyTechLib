import 'dart:math';

import '../../app/theme/tools.dart';

class Company {
  final String uuid;
  final String name;
  final String description;
  final String code;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  Company({
    this.uuid = '-1',
    this.name = '',
    this.description = '',
    this.code = '',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      code: json['code'] ?? '',
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
          json['updated_at'] != null ? Tools.formatDate(DateTime.parse(json['updated_at'])) : '',
    );
  }
}
