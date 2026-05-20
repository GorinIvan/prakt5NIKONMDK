class CatModel {
  final String id;
  final String name;
  final double price;
  final int ageMonths;

  const CatModel({
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

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: _asDouble(map['price']),
      ageMonths: _asInt(map['ageMonths']),
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
