class ClientModel {
  final String id;
  final String name;
  final String phone;

  const ClientModel({
    required this.id,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
      };

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }
}