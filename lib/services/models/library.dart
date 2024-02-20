class Library {
  final String id;
  final String name;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  Library({
    this.id = '-1',
    this.name = '',
    this.createdBy= '',
    this.createdAt= '',
    this.updatedAt= '',
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      id: json['id'],
      name: json['name'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
