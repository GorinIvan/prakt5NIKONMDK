import '../salon_database.dart';
import '../../domain/models/order_model.dart';
import '../../domain/appointment.dart';

class OrderRepository {
  final SalonDatabase db;

  OrderRepository(this.db);

  void insert(OrderModel m) {
    db.insertAppointment(
      Appointment(
        id: m.id,
        clientId: m.clientId,
        catId: m.catId,
        orderDate: m.orderDate,
      ),
    );
  }

  List<OrderModel> getAll() {
    final rows = db.getAllAppointments();
    return rows
        .map((r) => OrderModel(id: r.id, clientId: r.clientId, catId: r.catId, orderDate: r.orderDate))
        .toList();
  }

  OrderModel? getById(String id) {
    final row = db.getAppointmentById(id);
    return row == null ? null : OrderModel(id: row.id, clientId: row.clientId, catId: row.catId, orderDate: row.orderDate);
  }

  void delete(String id) => db.deleteAppointment(id);
}
