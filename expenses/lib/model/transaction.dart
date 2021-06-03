class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  @override
  String toString() {
    return 'Transaction{id: $id, title: $title, value: $value, date: $date}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
