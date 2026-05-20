import 'dart:io';
import 'text_validator.dart';

int? tryParsePositiveInt(String value) {
  final parsed = int.tryParse(value);
  if (parsed != null && parsed > 0) return parsed;
  return null;
}

double? tryParsePositiveDouble(String value) {
  final parsed = double.tryParse(value.replaceAll(',', '.'));
  if (parsed != null && parsed > 0) return parsed;
  return null;
}

int readPositiveInt(String label) {
  while (true) {
    final value = readLine(label);
    final parsed = tryParsePositiveInt(value);
    if (parsed != null) return parsed;
    stdout.writeln('Введите целое число больше 0.');
  }
}

double readPositiveDouble(String label) {
  while (true) {
    final value = readLine(label);
    final parsed = tryParsePositiveDouble(value);
    if (parsed != null) return parsed;
    stdout.writeln('Введите число больше 0.');
  }
}