import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repository/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      final prefs = await SharedPreferences.getInstance();
      try {
        final isAuthenticated =
        await loginRepository.login(event.username, event.password);

        if (isAuthenticated) {
          await prefs.setBool('isLoggedIn', true); // Save login state
          emit(LoginSuccess());
        } else {
          await prefs.setBool('isLoggedIn', false); // Save login state
          emit(LoginFailure(error: "Invalid username or password"));
        }
      } catch (e) {
        await prefs.setBool('isLoggedIn', false); // Save login state
        emit(LoginFailure(error: "An error occurred. Please try again."));
      }
    });
  }
}