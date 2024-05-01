import '../../app/theme/tools.dart';

class Library {
  final String uuid;
  final String name;
  final int projectCount;
  final String description;
  String? core_company;
  late String belongsTo;
  late String logoUrl;
  late String bannerUrl;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isPersonal;

  Library({
    this.uuid = '-1',
    this.name = '',
    this.projectCount = 0,
    this.description = '',
    this.logoUrl = '',
    this.bannerUrl = '',
    this.core_company = '',
    this.belongsTo = '',
    this.createdBy = '',
    this.createdAt  = null,
    this.updatedAt = null,
    this.isPersonal = true,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      uuid: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      projectCount: json['project_count'] ?? 0,
      description: json['description'] ?? '',
      core_company: json['core_company'],
      belongsTo: json['belongs_to'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      bannerUrl: json['banner_url'] ?? '',
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt:
          json['updated_at']  != null ?  DateTime.parse(json['updated_at']) : null,
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
    var json = {
      'name': name,
      'description': description,
      'core_company': core_company,
      'project_count': 0,
      'is_personal': isPersonal,
    };
    if (isPersonal) {
      json.remove('core_company');
      json['belongs_to'] = belongsTo;
    }
    return json;
  }
}
