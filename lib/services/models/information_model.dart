class Information {
  final String id;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  Information({
    this.id = '-1',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = '',
  });


  Information.fromJson(map)
      :id = map['id'],
        createdBy= map['createdBy'] ?? '',
        createdAt= map['createdAt']  ?? '',
        updatedAt = map['updatedAt']  ?? '';

}

