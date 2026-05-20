import 'package:salon/src/domain/models/client_model.dart';
import 'package:salon/src/domain/validators/number_validator.dart';
import 'package:salon/src/domain/validators/text_validator.dart';
import 'package:test/test.dart';

void main() {
  test('text validation returns true for non-empty text', () {
    expect(hasText('   '), isFalse);
  });

  test('number validation parses positive values', () {
    expect(tryParsePositiveInt('5'), 5);
    expect(tryParsePositiveInt('0'), isNull);
    expect(tryParsePositiveDouble('12,5'), 12.5);
  });

  test('ClientModel converts to map and back', () {
    const client = ClientModel(id: '1', name: 'Анна', phone: '+79990000000');

    final map = client.toMap();
    final restored = ClientModel.fromMap(map);

    expect(restored.id, client.id);
    expect(restored.name, client.name);
    expect(restored.phone, client.phone);
  });
}
