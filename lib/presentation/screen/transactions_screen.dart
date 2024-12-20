import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/transactions/transactions_bloc.dart';
import '../../logic/bloc/transactions/transactions_event.dart';
import '../../logic/bloc/transactions/transactions_state.dart';
import '../widgets/custom_app_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Transaction History', showBackButton: true),
      body: BlocProvider(
        create: (context) => TransactionBloc()..add(FetchTransactionsEvent()),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionEmptyState) {
              return const Center(child: Text('No transactions available.'));
            } else if (state is TransactionFailureState) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is TransactionHistoryState) {
              final transactions = state.transactions;
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: transaction.status == 'success'
                          ? Colors.green
                          : Colors.red,
                      child: Icon(
                        transaction.status == 'success'
                            ? Icons.check
                            : Icons.error,
                        color: Colors.white,
                      ),
                    ),
                    title: Text('₹${transaction.amount}'),
                    subtitle: Text(transaction.dateTime),
                    trailing: Text(transaction.status.toUpperCase(),
                        style: TextStyle(
                            color: transaction.status == 'success'
                                ? Colors.green
                                : Colors.red)),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
