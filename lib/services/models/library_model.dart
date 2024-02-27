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
    this.createdBy= '',
    this.createdAt= '',
    this.updatedAt= '',
    this.isPersonal= true,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      id: json['uuid'],
      name: json['name'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isPersonal: json['is_personal'],
    );
  }
}
