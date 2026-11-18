import 'dart:async';

import 'package:flutter/material.dart';

import '../models/order.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../services/shop_api.dart';
import '../widgets/section_card.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final _api = ShopApi();
  final _stopwatch = Stopwatch();
  final _log = <String>[];

  bool _loading = false;
  User? _user;
  List<Product>? _products;
  List<Order>? _orders;
  String? _ordersError;
  String? _error;

  String get _time =>
      '+${(_stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1)} c';

  void _addLog(String line) {
    if (!mounted) return;
    setState(() => _log.add('$_time  $line'));
  }

  /// Обгортка над запитом: пише в журнал момент старту і завершення.
  Future<T> _track<T>(String name, Future<T> Function() request) async {
    _addLog('$name - старт');
    try {
      final result = await request();
      _addLog('$name - готово');
      return result;
    } catch (e) {
      _addLog('$name - помилка');
      rethrow;
    }
  }

  void _reset() {
    _stopwatch
      ..reset()
      ..start();
    setState(() {
      _loading = true;
      _user = null;
      _products = null;
      _orders = null;
      _ordersError = null;
      _error = null;
      _log.clear();
    });
  }

  /// Послідовне виконання: кожен запит чекає завершення попереднього.
  Future<void> _loadSequential() async {
    _reset();
    try {
      final user = await _track('getUser()', _api.getUser);
      setState(() => _user = user);

      final products = await _track('getProducts()', _api.getProducts);
      setState(() => _products = products);

      await _loadOrders(_track('getOrders()', () => _api.getOrders(user.id)));
    } catch (e) {
      setState(() => _error = 'Не вдалося завантажити дані: $e');
    } finally {
      _finish();
    }
  }

  /// Конкурентне виконання: користувач і товари вантажаться одночасно,
  /// замовлення запитуються одразу після отримання користувача.
  Future<void> _loadConcurrent() async {
    _reset();

    final userFuture = _track('getUser()', _api.getUser);
    final productsFuture = _track('getProducts()', _api.getProducts);
    final ordersFuture = userFuture.then(
      (user) => _track('getOrders()', () => _api.getOrders(user.id)),
    );

    // Користувач з'являється на екрані, щойно прийде відповідь.
    userFuture.then((user) {
      if (mounted) setState(() => _user = user);
    }, onError: (_) {});

    try {
      final results = await Future.wait([
        userFuture,
        productsFuture,
      ]).timeout(const Duration(seconds: 5));

      setState(() {
        _user = results[0] as User;
        _products = results[1] as List<Product>;
      });

      await _loadOrders(ordersFuture);
    } on TimeoutException {
      ordersFuture.ignore();
      setState(() => _error = 'Перевищено час очікування відповіді');
    } catch (e) {
      ordersFuture.ignore();
      setState(() => _error = 'Не вдалося завантажити дані: $e');
    } finally {
      _finish();
    }
  }

  /// Помилка замовлень не ламає решту екрану - її показуємо окремо.
  Future<void> _loadOrders(Future<List<Order>> request) async {
    try {
      final orders = await request;
      setState(() => _orders = orders);
    } on ShopException catch (e) {
      setState(() => _ordersError = e.message);
    }
  }

  void _finish() {
    _stopwatch.stop();
    if (!mounted) return;
    setState(() {
      _loading = false;
      _log.add('$_time  Усього: ${_stopwatch.elapsedMilliseconds} мс');
    });
  }

  String _price(double value) => '${value.toStringAsFixed(2)} грн';

  String _date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Іванашко Д.В., Лаб. 11'),
        backgroundColor: colors.inversePrimary,
        bottom: _loading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4),
                child: LinearProgressIndicator(),
              )
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _loading ? null : _loadSequential,
                  child: const Text('Послідовно'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: _loading ? null : _loadConcurrent,
                  child: const Text('Паралельно'),
                ),
              ),
            ],
          ),
          SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            title: const Text('Імітувати помилку замовлень'),
            value: _api.failOrders,
            onChanged: _loading
                ? null
                : (v) => setState(() => _api.failOrders = v),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(_error!, style: TextStyle(color: colors.error)),
            ),
          SectionCard(
            title: 'Користувач',
            icon: Icons.person,
            loading: _loading,
            child: _user == null
                ? null
                : Text('${_user!.name}\n${_user!.email}  (id ${_user!.id})'),
          ),
          SectionCard(
            title: 'Товари',
            icon: Icons.shopping_bag,
            loading: _loading,
            child: _products == null
                ? null
                : Column(
                    children: [
                      for (final p in _products!)
                        Row(
                          children: [
                            Expanded(child: Text(p.title)),
                            Text(_price(p.price)),
                          ],
                        ),
                    ],
                  ),
          ),
          SectionCard(
            title: 'Замовлення',
            icon: Icons.receipt_long,
            loading: _loading,
            error: _ordersError,
            child: _orders == null
                ? null
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final o in _orders!)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '№${o.id} від ${_date(o.date)} - ${o.status}\n'
                            '${o.items.join(', ')}: ${_price(o.total)}',
                          ),
                        ),
                    ],
                  ),
          ),
          if (_log.isNotEmpty)
            SectionCard(
              title: 'Журнал запитів',
              icon: Icons.timer_outlined,
              loading: false,
              child: Text(
                _log.join('\n'),
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
