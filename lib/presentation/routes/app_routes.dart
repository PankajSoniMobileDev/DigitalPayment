import 'package:digital_payment_project/presentation/screen/transactions_screen.dart';
import 'package:flutter/material.dart';

import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import '../screen/send_money_screen.dart';

class AppRoutes {
  // Define route names
  static const String login = '/login';
  static const String dashboard = '/home';
  static const String sendMoney = '/sendMoney';
  static const String transactionHistory = '/transactionHistory';

  // Define route map
  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    dashboard: (context) => HomeScreen(),
    sendMoney: (context) => SendMoneyScreen(),
    transactionHistory: (context) => TransactionsScreen(),
  };
}