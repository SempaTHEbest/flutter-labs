import '../models/order.dart';
import '../models/product.dart';
import '../models/user.dart';

class ShopException implements Exception {
  final String message;

  const ShopException(this.message);

  @override
  String toString() => message;
}

/// Імітація API інтернет-магазину: кожен метод чекає певний час,
/// як справжній мережевий запит, і повертає дані.
class ShopApi {
  /// Якщо true - запит замовлень завершується помилкою.
  bool failOrders = false;

  Future<User> getUser() async {
    await Future.delayed(const Duration(seconds: 1));

    return const User(id: 10, name: 'Іванашко Д.', email: 'ivanashko@shop.ua');
  }

  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    return const [
      Product(id: 1, title: 'Навушники', price: 1299),
      Product(id: 2, title: 'Клавіатура', price: 2150),
      Product(id: 3, title: 'Мишка', price: 749.5),
      Product(id: 4, title: 'Монітор 27"', price: 8999),
      Product(id: 5, title: 'USB-хаб', price: 499),
    ];
  }

  Future<List<Order>> getOrders(int userId) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (failOrders) {
      throw const ShopException('Сервер замовлень не відповідає (500)');
    }

    return [
      Order(
        id: 1001,
        date: DateTime(2026, 10, 3),
        items: const ['Навушники', 'USB-хаб'],
        total: 1798,
        status: 'Доставлено',
      ),
      Order(
        id: 1002,
        date: DateTime(2026, 11, 14),
        items: const ['Клавіатура'],
        total: 2150,
        status: 'В дорозі',
      ),
    ];
  }
}
