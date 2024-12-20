import 'package:digital_payment_project/logic/bloc/transactions/transactions_event.dart';
import 'package:digital_payment_project/logic/bloc/transactions/transactions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/model/transaction_model.dart';
import '../../../database/database_helper.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitialState());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is AddTransactionEvent) {
      yield* _handleAddTransaction(event);
    } else if (event is FetchTransactionsEvent) {
      yield* _handleFetchTransactions();
    }
  }

  Stream<TransactionState> _handleAddTransaction(AddTransactionEvent event) async* {
    try {
      final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      // Ensure amount is passed as a double
      final transaction = TransactionModel(
        id: 0,
        amount: double.tryParse(event.amount as String) ?? 0.0, // Ensure amount is a double
        status: event.isSuccess ? 'success' : 'failure',
        dateTime: dateTime,
      );

      await DatabaseHelper.instance.insertTransaction(transaction);
      yield TransactionSuccessState();
    } catch (e) {
      yield TransactionFailureState(message: e.toString());
    }
  }

  Stream<TransactionState> _handleFetchTransactions() async* {
    try {
      final transactions = await DatabaseHelper.instance.fetchTransactions();
      if (transactions.isEmpty) {
        yield TransactionEmptyState();
      } else {
        yield TransactionHistoryState(transactions: transactions);
      }
    } catch (e) {
      yield TransactionFailureState(message: e.toString());
    }
  }
}