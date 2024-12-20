class TransactionModel {
  final int id;
  final double amount;  // Update to double for SQLite compatibility
  final String status;  // success or failure
  final String dateTime;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.status,
    required this.dateTime,
  });

  // Convert a TransactionModel to a Map (for database insertion)
  Map<String, dynamic> toMap() {
    return {
      'id': id,  // SQLite will handle auto-increment ID if needed
      'amount': amount,  // Ensure amount is stored as double
      'status': status,
      'dateTime': dateTime,
    };
  }

  // Convert a Map to a TransactionModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int, // Make sure 'id' is an int
      amount: (map['amount'] as num).toDouble(),  // Convert 'amount' to double
      status: map['status'] as String,  // Ensure 'status' is a String
      dateTime: map['dateTime'] as String,  // Ensure 'dateTime' is a String
    );
  }
}