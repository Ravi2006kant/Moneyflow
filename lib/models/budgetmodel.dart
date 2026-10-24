class Budgetmodel {
  Budgetmodel({
    required this.budgetName,
    required this.category,
    required this.spendingLimit,
    required this.month,
    required this.alert,
  });
  final String budgetName;
  final String category;
  final double spendingLimit;
  final String month;
  final String alert;
  Map<String, Object?> toMap() {
    return {
      'budgetName': budgetName,
      'category': category,
      'spendingLimit': spendingLimit,
      'month':month,
      'alert':alert
    };
  }
}
