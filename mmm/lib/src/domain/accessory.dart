import 'identity.dart';

class Accessory implements Identity {
  @override
  final String id;
  final String name;
  final double price;
  final int quantity;

  const Accessory({
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

  factory Accessory.fromMap(Map<String, dynamic> map) {
    double _asDouble(Object? value) {
      if (value is num) return value.toDouble();
      throw FormatException('Expected number', value);
    }

    int _asInt(Object? value) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      throw FormatException('Expected int', value);
    }

    return Accessory(
      id: map['id'] as String,
      name: map['name'] as String,
      price: _asDouble(map['price']),
      quantity: _asInt(map['quantity']),
    );
  }
}
