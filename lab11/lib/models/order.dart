class Order {
  final int id;
  final DateTime date;
  final List<String> items;
  final double total;
  final String status;

  const Order({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
  });
}
