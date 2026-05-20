# salon

Консольное приложение на Dart для темы "магазин кошек". Проект хранит данные в SQLite и работает через простое текстовое меню в терминале.

## Что умеет

- хранить покупателей;
- хранить кошек;
- хранить аксессуары;
- хранить заказы;
- добавлять, просматривать и удалять записи;
- валидировать простой текст и числа;
- конвертировать модели в `Map` и обратно.

## Структура проекта

```text
bin/
  main.dart
lib/
  my_app.dart
  src/
    cli/
      input_helper.dart
      menu.dart
    data/
      salon_database.dart
      repositories/
    domain/
      appointment.dart
      accessory.dart
      beauty_service.dart
      client.dart
      identity.dart
      models/
        accessory_model.dart
        cat_model.dart
        client_model.dart
        order_model.dart
      validators/
        number_validator.dart
        text_validator.dart
test/
  mmm_test.dart
```

## Слои проекта

### `domain`
Содержит модели данных и простую валидацию. Здесь лежат сущности приложения и функции проверки ввода.

### `data`
Содержит `SalonDatabase` и репозитории. Этот слой отвечает за SQLite, таблицы и CRUD-операции.

### `cli`
Содержит меню и функции ввода/вывода для работы в терминале.

### `bin`
Точка входа приложения. Файл `bin/main.dart` запускает меню и закрывает базу данных.

## Модели

В папке `lib/src/domain/models` лежат четыре простые модели:

- `ClientModel` — покупатель;
- `CatModel` — кошка;
- `AccessoryModel` — аксессуар;
- `OrderModel` — заказ.

У каждой модели есть `toMap()` и `fromMap()`.

## Валидация

В папке `lib/src/domain/validators` есть простые функции:

- `hasText()` — проверка на непустой текст;
- `tryParsePositiveInt()` — попытка разобрать положительное целое число;
- `tryParsePositiveDouble()` — попытка разобрать положительное дробное число.

## Тесты

В проекте есть 3 очень простых теста:

1. проверка текста через `hasText()`;
2. проверка чисел через `tryParsePositiveInt()` и `tryParsePositiveDouble()`;
3. проверка round-trip для `ClientModel.toMap()` / `ClientModel.fromMap()`.

## Запуск

Установить зависимости:

```bash
dart pub get
```

Запустить приложение:

```bash
dart run bin/main.dart
```

Запустить тесты:

```bash
dart test
```
