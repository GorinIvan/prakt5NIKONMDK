import 'identity.dart';

class Appointment implements Identity {
  @override
  final String id;
  final String clientId;
  final String catId;
  final DateTime orderDate;

  const Appointment({
    required this.id,
    required this.clientId,
    required this.catId,
    required this.orderDate,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'clientId': clientId,
        'catId': catId,
        'orderDate': orderDate.toIso8601String(),
      };

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] as String,
      clientId: map['clientId'] as String,
      catId: map['catId'] as String,
      orderDate: DateTime.parse(map['orderDate'] as String),
    );
  }
}
