class TransactionModel {
  final String id;
  final String note;
  final double amount;
  final DateTime date;
  final String category;
  final String type;

  TransactionModel({
    required this.id,
    required this.note,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
  });
}
