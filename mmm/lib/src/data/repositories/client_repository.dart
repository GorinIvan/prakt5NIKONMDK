import '../salon_database.dart';
import '../../domain/models/client_model.dart';
import '../../domain/client.dart';

class ClientRepository {
  final SalonDatabase db;

  ClientRepository(this.db);

  void insert(ClientModel m) {
    db.insertClient(Client(id: m.id, name: m.name, phone: m.phone));
  }

  List<ClientModel> getAll() {
    final rows = db.getAllClients();
    return rows
        .map((r) => ClientModel(id: r.id, name: r.name, phone: r.phone))
        .toList();
  }

  ClientModel? getById(String id) {
    final row = db.getClientById(id);
    return row == null ? null : ClientModel(id: row.id, name: row.name, phone: row.phone);
  }

  void delete(String id) => db.deleteClient(id);
}
