import 'package:digital_payment_project/presentation/screen/home_screen.dart';
import 'package:digital_payment_project/presentation/screen/login_screen.dart';
import 'package:digital_payment_project/presentation/screen/send_money_screen.dart';
import 'package:digital_payment_project/presentation/screen/splash_screen.dart';
import 'package:digital_payment_project/presentation/screen/transactions_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/login_repository.dart';
import 'data/service/dio_service.dart';
import 'logic/bloc/login/login_bloc.dart';

void main() {
  final dio = initializeDio();
  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  const MyApp({super.key, required this.dio});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            loginRepository: LoginRepository(dio),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Send Money App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/sendMoney': (context) => SendMoneyScreen(),
          '/transactionHistory': (context) => TransactionsScreen(),
        },
      ),
    );
  }
}
