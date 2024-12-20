Digital Payment Project

A Flutter application that demonstrates a digital payment system with features like sending money and managing transactions using SQLite as the local database. The project follows a modular architecture and uses the BLoC state management pattern for scalability and maintainability.

Features
	•	Send Money: Enter an amount and send money with real-time success or failure feedback.
	•	Transaction History: View a list of all past transactions stored locally in SQLite.
	•	Database Management: Persistent local storage using sqflite.
	•	Clean Architecture: Modular separation of UI, logic, and data layers.
	•	State Management: Leveraging the power of flutter_bloc.

 Getting Started

Prerequisites
	•	Flutter SDK: Make sure you have Flutter installed on your system. You can download it from Flutter’s website.
	•	Dependencies: Install all required dependencies by running:
 flutter pub get

 Running the Project
	1.	Clone the repository:
 git clone https://github.com/your-repo/digital-payment-project.git
cd digital-payment-project
	2.	Run the app:
 flutter run

 Supported Platforms
	•	Android
	•	iOS

 Project Structure

The project follows a modular structure for better code management:

lib/
│
├── blocs/
│   ├── send_money_bloc.dart
│   ├── transaction_list_bloc.dart
│   └── ...
├── data/
│   ├── model/
│   │   └── transaction_model.dart
│   ├── repository/
│   │   └── transaction_repository.dart
│   └── ...
├── database/
│   └── database_helper.dart
├── screens/
│   ├── send_money_screen.dart
│   ├── transaction_list_screen.dart
│   └── ...
├── widgets/
│   └── custom_app_bar.dart
└── main.dart

Key Components

1. Database Helper

database_helper.dart provides utility methods to interact with the SQLite database for CRUD operations.

2. State Management with BLoC

BLoC (Business Logic Component) is used to manage states for the Send Money and Transaction List screens, ensuring the separation of UI and business logic.
	•	Send Money Bloc: Handles sending money and saving transactions to the database.
	•	Transaction List Bloc: Retrieves transactions from the database and manages the transaction history view.

3. Transaction Model

A Dart model class for representing transaction data with attributes like:
	•	id: Unique identifier.
	•	amount: Amount of money sent.
	•	status: Success or failure status.
	•	dateTime: Timestamp of the transaction.

 Screens

1. Send Money Screen
	•	Enter the amount to send.
	•	Validates the input and provides feedback using a modal bottom sheet.

2. Transaction List Screen
	•	Displays all transactions stored in the SQLite database.
	•	Lists transaction details such as amount, status, and date.

Dependencies

Here are the key dependencies used in this project:
Dependency	Usage
flutter_bloc	State management using BLoC pattern
sqflite	SQLite database integration
path	Provides file system paths for SQLite

To add these dependencies, ensure your pubspec.yaml contains:
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.0.0
  sqflite: ^2.0.0
  path: ^1.8.0

  How It Works
	1.	Send Money:
	•	User inputs the amount.
	•	The app validates the input and saves the transaction in the SQLite database.
	•	Displays a success or failure message in a modal bottom sheet.
	2.	Transaction List:
	•	Fetches transactions from SQLite.
	•	Displays the list of transactions with real-time updates.

 Future Enhancements
	•	Add network connectivity for remote database syncing.
	•	Implement user authentication.
	•	Enhance the UI with animations and themes.

 Contributing

We welcome contributions! Follow these steps to contribute:
	1.	Fork the repository.
	2.	Create a feature branch:
 git checkout -b feature-name
 	3.	Commit your changes and push to your fork.
	4.	Create a pull request.
