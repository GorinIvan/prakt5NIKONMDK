import 'dart:io';

bool hasText(String value) => value.trim().isNotEmpty;

String readLine(String label) {
  stdout.write(label);
  return stdin.readLineSync()?.trim() ?? '';
}

String readNonEmpty(String label) {
  while (true) {
    final value = readLine(label);
    if (hasText(value)) return value;
    stdout.writeln('Значение не должно быть пустым.');
  }
}