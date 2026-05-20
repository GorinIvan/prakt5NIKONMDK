import '../salon_database.dart';
import '../../domain/models/accessory_model.dart';
import '../../domain/accessory.dart';

class AccessoryRepository {
  final SalonDatabase db;

  AccessoryRepository(this.db);

  void insert(AccessoryModel m) {
    db.insertAccessory(
      Accessory(
        id: m.id,
        name: m.name,
        price: m.price,
        quantity: m.quantity,
      ),
    );
  }

  List<AccessoryModel> getAll() {
    final rows = db.getAllAccessories();
    return rows
        .map((r) => AccessoryModel(id: r.id, name: r.name, price: r.price, quantity: r.quantity))
        .toList();
  }

  AccessoryModel? getById(String id) {
    final row = db.getAccessoryById(id);
    return row == null ? null : AccessoryModel(id: row.id, name: row.name, price: row.price, quantity: row.quantity);
  }

  void delete(String id) => db.deleteAccessory(id);
}
