import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import '../domain/appointment.dart';
import '../domain/beauty_service.dart';
import '../domain/client.dart';
import '../domain/accessory.dart';

class SalonDatabase {
  final Database _sqlite;

  SalonDatabase(String filePath) : _sqlite = sqlite3.open(filePath) {
    _createTables();
  }

  factory SalonDatabase.inApp() {
    final filePath = p.join(Directory.current.path, 'salon.db');
    return SalonDatabase(filePath);
  }

  void _createTables() {
    _sqlite.execute('DROP TABLE IF EXISTS orders;');
    _sqlite.execute('DROP TABLE IF EXISTS cats;');
    _sqlite.execute('DROP TABLE IF EXISTS accessories;');
    _sqlite.execute('DROP TABLE IF EXISTS appointments;');
    _sqlite.execute('DROP TABLE IF EXISTS services;');
    _sqlite.execute('DROP TABLE IF EXISTS clients;');

    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS clients (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT NOT NULL
      );
    ''');

    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS cats (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        ageMonths INTEGER NOT NULL
      );
    ''');

    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS accessories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL
      );
    ''');

    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id TEXT PRIMARY KEY,
        clientId TEXT NOT NULL,
        catId TEXT NOT NULL,
        orderDate TEXT NOT NULL,
        FOREIGN KEY (clientId) REFERENCES clients(id) ON DELETE CASCADE,
        FOREIGN KEY (catId) REFERENCES cats(id) ON DELETE CASCADE
      );
    ''');
  }

  void insertClient(Client client) {
    _sqlite.execute(
      'INSERT OR REPLACE INTO clients(id,name,phone) VALUES(?,?,?)',
      [client.id, client.name, client.phone],
    );
  }

  List<Client> getAllClients() {
    final rows = _sqlite.select('SELECT id,name,phone FROM clients');
    return rows.map((row) => Client.fromMap(row)).toList();
  }

  Client? getClientById(String id) {
    final rows = _sqlite.select(
      'SELECT id,name,phone FROM clients WHERE id=?',
      [id],
    );
    return rows.isNotEmpty ? Client.fromMap(rows.first) : null;
  }

  void deleteClient(String id) {
    _sqlite.execute('DELETE FROM clients WHERE id=?', [id]);
  }

  void insertService(BeautyService service) {
    _sqlite.execute(
      'INSERT OR REPLACE INTO cats(id,name,price,ageMonths) VALUES(?,?,?,?)',
      [service.id, service.name, service.price, service.ageMonths],
    );
  }

  List<BeautyService> getAllServices() {
    final rows = _sqlite.select(
      'SELECT id,name,price,ageMonths FROM cats',
    );
    return rows.map((row) => BeautyService.fromMap(row)).toList();
  }

  BeautyService? getServiceById(String id) {
    final rows = _sqlite.select(
      'SELECT id,name,price,ageMonths FROM cats WHERE id=?',
      [id],
    );
    return rows.isNotEmpty ? BeautyService.fromMap(rows.first) : null;
  }

  void deleteService(String id) {
    _sqlite.execute('DELETE FROM cats WHERE id=?', [id]);
  }

  void insertAccessory(Accessory accessory) {
    _sqlite.execute(
      'INSERT OR REPLACE INTO accessories(id,name,price,quantity) VALUES(?,?,?,?)',
      [accessory.id, accessory.name, accessory.price, accessory.quantity],
    );
  }

  List<Accessory> getAllAccessories() {
    final rows = _sqlite.select(
      'SELECT id,name,price,quantity FROM accessories',
    );
    return rows.map((row) => Accessory.fromMap(row)).toList();
  }

  Accessory? getAccessoryById(String id) {
    final rows = _sqlite.select(
      'SELECT id,name,price,quantity FROM accessories WHERE id=?',
      [id],
    );
    return rows.isNotEmpty ? Accessory.fromMap(rows.first) : null;
  }

  void deleteAccessory(String id) {
    _sqlite.execute('DELETE FROM accessories WHERE id=?', [id]);
  }

  void insertAppointment(Appointment appointment) {
    _sqlite.execute(
      'INSERT OR REPLACE INTO orders(id,clientId,catId,orderDate) VALUES(?,?,?,?)',
      [
        appointment.id,
        appointment.clientId,
        appointment.catId,
        appointment.orderDate.toIso8601String(),
      ],
    );
  }

  List<Appointment> getAllAppointments() {
    final rows = _sqlite.select(
      'SELECT id,clientId,catId,orderDate FROM orders',
    );
    return rows.map((row) => Appointment.fromMap(row)).toList();
  }

  Appointment? getAppointmentById(String id) {
    final rows = _sqlite.select(
      'SELECT id,clientId,catId,orderDate FROM orders WHERE id=?',
      [id],
    );
    return rows.isNotEmpty ? Appointment.fromMap(rows.first) : null;
  }

  void deleteAppointment(String id) {
    _sqlite.execute('DELETE FROM orders WHERE id=?', [id]);
  }

  void close() {
    _sqlite.dispose();
  }
}
