abstract class TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  final double amount;
  final bool isSuccess;

  AddTransactionEvent({required this.amount, required this.isSuccess});
}

class FetchTransactionsEvent extends TransactionEvent {}