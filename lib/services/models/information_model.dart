class Information {
  final String id;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  Information({
    this.id = '-1',
    this.createdBy= '',
    this.createdAt= '',
    this.updatedAt= '',
  });

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      id: json['id'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

