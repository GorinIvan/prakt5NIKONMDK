import 'identity.dart';

class BeautyService implements Identity {
  @override
  final String id;
  final String name;
  final double price;
  final int ageMonths;

  const BeautyService({
    required this.id,
    required this.name,
    required this.price,
    required this.ageMonths,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'ageMonths': ageMonths,
      };

  factory BeautyService.fromMap(Map<String, dynamic> map) {
    double _asDouble(Object? value) {
      if (value is num) return value.toDouble();
      throw FormatException('Expected number', value);
    }

    int _asInt(Object? value) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      throw FormatException('Expected int', value);
    }

    return BeautyService(
      id: map['id'] as String,
      name: map['name'] as String,
      price: _asDouble(map['price']),
      ageMonths: _asInt(map['ageMonths']),
    );
  }

  @override
  String toString() => '$name - $price ₽, $ageMonths мес.';
}
