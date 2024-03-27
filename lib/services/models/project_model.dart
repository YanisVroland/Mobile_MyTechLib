
import 'dart:math';

import '../../app/theme/tools.dart';

class Project {
  final String uuid;
  final String name;
  final String description;
  final String type;
  final String? core_company;
  final String core_library;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  Project({
    this.uuid = '-1',
    this.name = '',
    this.description = '',
    this.type = '',
    this.core_company = '',
    this.core_library = '',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      core_company: json['core_company'],
      core_library: json['core_library'] ?? '' ,
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
          json['updated_at'] != null ? Tools.formatDate(DateTime.parse(json['updated_at'])) : '',
    );
  }

  Map<String, dynamic> toJson() {
    var json= {
      'name': name,
      'type': type,
      'description': description,
      'core_company': core_company,
      'core_library': core_library,
    };
    return json;
  }
}
