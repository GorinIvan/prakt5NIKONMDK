import 'dart:io';

import '../data/salon_database.dart';
import '../domain/appointment.dart';
import '../domain/beauty_service.dart';
import '../domain/client.dart';

void runMenu(SalonDatabase db) {
  while (true) {
    stdout.writeln('''
Магазин кошек
1 — список покупателей
2 — добавить покупателя
3 — удалить покупателя по id
4 — список кошек
5 — добавить кошку
6 — удалить кошку по id
7 — список заказов
8 — добавить заказ
9 — удалить заказ по id
10 — показать всё из базы (как таблицы в консоли)
0 — выход
Выберите пункт:''');

    final choice = stdin.readLineSync()?.trim() ?? '';
    switch (choice) {
      case '1':
        _printClients(db);
        break;
      case '2':
        _addClient(db);
        break;
      case '3':
        _deleteClient(db);
        break;
      case '4':
        _printServices(db);
        break;
      case '5':
        _addService(db);
        break;
      case '6':
        _deleteService(db);
        break;
      case '7':
        _printAppointments(db);
        break;
      case '8':
        _addAppointment(db);
        break;
      case '9':
        _deleteAppointment(db);
        break;
      case '10':
        _printAllFromDb(db);
        break;
      case '0':
        stdout.writeln('До свидания.');
        return;
      default:
        stdout.writeln('Неизвестная команда.');
    }
    stdout.writeln();
  }
}

void _printClients(SalonDatabase db) {
  final list = db.getAllClients();
  if (list.isEmpty) {
    stdout.writeln('Покупателей нет.');
    return;
  }
  for (final c in list) {
    stdout.writeln('id: ${c.id} | ${c.name} | ${c.phone}');
  }
}

void _printServices(SalonDatabase db) {
  final list = db.getAllServices();
  if (list.isEmpty) {
    stdout.writeln('Кошек нет.');
    return;
  }
  for (final s in list) {
    stdout.writeln('id: ${s.id} | ${s.name} | ${s.price} ₽ | ${s.ageMonths} мес.');
  }
}

void _printAppointments(SalonDatabase db) {
  final list = db.getAllAppointments();
  if (list.isEmpty) {
    stdout.writeln('Заказов нет.');
    return;
  }
  for (final a in list) {
    stdout.writeln(
      'id: ${a.id} | покупатель: ${a.clientId} | кошка: ${a.catId} | ${a.orderDate.toLocal()}',
    );
  }
}

void _printAllFromDb(SalonDatabase db) {
  stdout.writeln('Покупатели');
  _printClients(db);
  stdout.writeln('Кошки');
  _printServices(db);
  stdout.writeln(' Заказы ');
  _printAppointments(db);
}

void _addClient(SalonDatabase db) {
  final id = _read('id покупателя: ');
  final name = _read('имя покупателя: ');
  final phone = _read('телефон: ');

  db.insertClient(Client(id: id, name: name, phone: phone));
  stdout.writeln('Покупатель сохранён.');
}

void _deleteClient(SalonDatabase db) {
  final id = _read('id покупателя для удаления: ');
  db.deleteClient(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addService(SalonDatabase db) {
  final id = _read('id кошки: ');
  final name = _read('кличка: ');
  final price = double.parse(_read('цена (число): ').replaceAll(',', '.'));
  final ageMonths = int.parse(_read('возраст в месяцах: '));

  db.insertService(
    BeautyService(
      id: id,
      name: name,
      price: price,
      ageMonths: ageMonths,
    ),
  );
  stdout.writeln('Кошка сохранена.');
}

void _deleteService(SalonDatabase db) {
  final id = _read('id кошки для удаления: ');
  db.deleteService(id);
  stdout.writeln('Готово (если id был в базе).');
}

void _addAppointment(SalonDatabase db) {
  stdout.writeln('Доступные покупатели:');
  _printClients(db);
  stdout.writeln('Доступные кошки:');
  _printServices(db);

  final id = _read('id заказа: ');
  final clientId = _read('id покупателя: ');
  final catId = _read('id кошки: ');
  final orderDateString = _read(
    'дата заказа (например 2026-05-07T14:30:00): ',
  );
  final parsedDate = DateTime.parse(orderDateString);

  db.insertAppointment(
    Appointment(
      id: id,
      clientId: clientId,
      catId: catId,
      orderDate: parsedDate,
    ),
  );
  stdout.writeln('Заказ сохранён.');
}

void _deleteAppointment(SalonDatabase db) {
  final id = _read('id заказа для удаления: ');
  db.deleteAppointment(id);
  stdout.writeln('Готово (если id был в базе).');
}

String _read(String label) {
  stdout.write(label);
  return stdin.readLineSync()?.trim() ?? '';
}
