
import '../../app/theme/tools.dart';

class Library {
  final String id;
  final String name;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  final bool isPersonal;

  Library({
    this.id = '-1',
    this.name = '',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.isPersonal = true,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      id: json['uuid'] ?? '-1',
      name: json['name'] ?? '',
      createdBy: json['created_by']['name'] + ' ' + json['created_by']['lastName'] ?? '',
      createdAt:
          json['created_at'] != null ? Tools.formatDate(DateTime.parse(json['created_at'])) : '',
      updatedAt:
          json['updated_at'] != null ? Tools.formatDate(DateTime.parse(json['updated_at'])) : '',
      isPersonal: json['is_personal'] ?? true,
    );
  }
}
