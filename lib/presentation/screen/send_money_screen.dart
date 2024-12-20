import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/model/transaction_model.dart';
import '../../database/database_helper.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({Key? key}) : super(key: key);

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();

  // Function to validate and submit the amount
  void _submitAmount() async {
    final String amountText = _amountController.text.trim();
    if (amountText.isEmpty || double.tryParse(amountText) == null) {
      _showBottomSheet(success: false, message: 'Invalid amount entered.');
    } else {
      // Create the TransactionModel object
      final transaction = TransactionModel(
        id: 0, // auto-generated ID from SQLite
        amount: double.parse(amountText),
        status: 'success', // You can update the status as per your logic
        dateTime: DateTime.now().toString(),
      );

      // Insert the transaction into the database
      await DatabaseHelper.instance.insertTransaction(transaction);

      _showBottomSheet(success: true, message: 'Amount sent successfully!');
    }
  }

  // Function to display the bottom sheet
  void _showBottomSheet({required bool success, required String message}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width, // Full screen width
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, -4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  success ? Icons.check_circle : Icons.error,
                  color: success ? Colors.green : Colors.red,
                  size: 50,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: success ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        leading: BackButton(),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Send Money',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Accept digits only
                    LengthLimitingTextInputFormatter(5), // Limit to 5 digits
                  ],
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    prefixIcon: const Icon(Icons.currency_rupee),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _submitAmount,
                  icon: const Icon(Icons.send),
                  label: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}