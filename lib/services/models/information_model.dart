
import 'dart:math';

import '../../app/theme/tools.dart';

class Information {
  final String uuid;
  final String type;
  final String? core_company;
  final String? core_project;
  final String core_library;
  final String createdBy;
  final DateTime? createdAt;

  Information({
    this.uuid = '-1',
    this.type = '',
    this.core_company = '',
    this.core_library = '',
    this.core_project = '',
    this.createdBy = '',
    this.createdAt = null,
  });

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      uuid: json['uuid'] ?? '-1',
      type: json['type'] ?? '',
      core_company: json['core_company'] ?? '' ,
      core_library: json['core_library'] != null ? json['core_library']['name']: '' ,
      core_project: json['core_project'] ?? '' ,
      createdBy: json['created_by'] != null ? json['created_by']['name'] + ' ' + json['created_by']['lastName'] : '' ,
      createdAt:
          json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    var json= {
      'type': type,
      'core_company': core_company,
      'core_library': core_library,
      'core_project': core_project,
    };
    return json;
  }
}
