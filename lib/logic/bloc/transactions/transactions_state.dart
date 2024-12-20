// transaction_state.dart
import '../../../data/model/transaction_model.dart';

abstract class TransactionState {}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionSuccessState extends TransactionState {}

class TransactionFailureState extends TransactionState {
  final String message;

  TransactionFailureState({required this.message});
}

class TransactionHistoryState extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionHistoryState({required this.transactions});
}

class TransactionEmptyState extends TransactionState {}