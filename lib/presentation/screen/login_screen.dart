import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/login/login_bloc.dart';
import '../../logic/bloc/login/login_event.dart';
import '../../logic/bloc/login/login_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Path to your logo image
              height: 100,       // Adjust height as needed
              width: 100,        // Adjust width as needed
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  // Navigate to home screen on successful login
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomeScreen(),),
                  );
                } else if (state is LoginFailure) {
                  // Show error message on login failure
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text;
                    final password = passwordController.text;

                    if (username.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("User Name field is required."),
                        ),
                      );
                      return;
                    }
                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password field is required."),
                        ),
                      );
                      return;
                    }

                    // Dispatch login event
                    context.read<LoginBloc>().add(
                      LoginButtonPressed(
                        username: username,
                        password: password,
                      ),
                    );
                  },
                  child: const Text("Login"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}