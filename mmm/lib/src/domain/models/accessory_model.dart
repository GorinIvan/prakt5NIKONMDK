class AccessoryModel {
  final String id;
  final String name;
  final double price;
  final int quantity;

  const AccessoryModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  factory AccessoryModel.fromMap(Map<String, dynamic> map) {
    return AccessoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: _asDouble(map['price']),
      quantity: _asInt(map['quantity']),
    );
  }

  static double _asDouble(Object? value) {
    if (value is num) return value.toDouble();
    throw FormatException('Ожидали число', value);
  }

  static int _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    throw FormatException('Ожидали целое число', value);
  }
}