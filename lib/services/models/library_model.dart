
import '../../app/theme/tools.dart';

class Library {
  final String uuid;
  final String name;
  final String description;
  final String? core_company;
  final String belongsTo;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  final bool isPersonal;

  Library({
    this.uuid = '-1',
    this.name = '',
    this.description = '',
    this.core_company = '',
    this.belongsTo = '',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.isPersonal = true,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      core_company: json['core_company'],
      belongsTo: json['belongs_to'] ?? '',
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
          json['updated_at'] != null ? Tools.formatDate(DateTime.parse(json['updated_at'])) : '',
      isPersonal: json['is_personal'] ?? true,
    );
  }

  factory Library.fromJsonInformation(Map<String, dynamic> json) {
    return Library(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    var json= {
      'name': name,
      'description': description,
      'core_company': core_company,
      'is_personal': isPersonal,
    };
    if(isPersonal){
      json.remove('core_company');
      json['belongs_to'] = belongsTo;
    }
    return json;
  }
}
