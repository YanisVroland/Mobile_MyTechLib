
import 'dart:math';

import 'package:my_tech_lib/services/models/project_model.dart';

import '../../app/theme/tools.dart';
import 'library_model.dart';

class Information {
  final String uuid;
  final String type;
  final String? core_company;
  final Project? core_project;
  final Library? core_library;
  final String createdBy;
  final DateTime? createdAt;
  final bool isProject;

  Information({
    this.uuid = '-1',
    this.type = '',
    this.core_company = null,
    this.core_library = null,
    this.core_project = null,
    this.createdBy = '',
    this.createdAt = null,
    this.isProject = false,
  });

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      uuid: json['uuid'] ?? '-1',
      type: json['type'] ?? '',
      core_company: json['core_company'] ?? '' ,
      core_library: json['core_library'] != '' ? Library.fromJsonInformation(json['core_library']) : null,
      core_project: json['core_project'] != ''? Project.fromJsonInformation(json['core_project']) : null,
      isProject: json['core_project'] != '',
      createdBy: json['created_by'] != null ? json['created_by']['name'] + ' ' + json['created_by']['lastName'] : '' ,
      createdAt:
          json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    var json= {
      'type': type,
      'core_company': core_company,
      'core_library': core_library != null ? core_library!.toJson() : '',
      'core_project': core_project != null ? core_project!.toJson() : '',
    };
    return json;
  }
}
