import 'package:flutter_bloc/flutter_bloc.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletState(balance: 500.0)) {
    on<FetchWalletBalance>((event, emit) {
      emit(WalletState(balance: state.balance, isHidden: state.isHidden));
    });

    on<ToggleBalanceVisibility>((event, emit) {
      emit(WalletState(balance: state.balance, isHidden: !state.isHidden));
    });
  }
}