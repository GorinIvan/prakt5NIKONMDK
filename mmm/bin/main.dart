import 'package:salon/my_app.dart';

void main(List<String> arguments) {
  final db = SalonDatabase.inApp();
  try {
    runMenu(db);
  } finally {
    db.close();
  }
}
