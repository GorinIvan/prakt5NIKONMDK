import '../salon_database.dart';
import '../../domain/models/cat_model.dart';
import '../../domain/beauty_service.dart';

class CatRepository {
  final SalonDatabase db;

  CatRepository(this.db);

  void insert(CatModel m) {
    db.insertService(
      BeautyService(
        id: m.id,
        name: m.name,
        price: m.price,
        ageMonths: m.ageMonths,
      ),
    );
  }

  List<CatModel> getAll() {
    final rows = db.getAllServices();
    return rows
        .map((r) => CatModel(id: r.id, name: r.name, price: r.price, ageMonths: r.ageMonths))
        .toList();
  }

  CatModel? getById(String id) {
    final row = db.getServiceById(id);
    return row == null ? null : CatModel(id: row.id, name: row.name, price: row.price, ageMonths: row.ageMonths);
  }

  void delete(String id) => db.deleteService(id);
}
