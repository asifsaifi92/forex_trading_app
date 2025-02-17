import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;

  NetworkCubit(this._connectivity) : super(NetworkInitial()) {
    _monitorNetwork();
  }

  void _monitorNetwork() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(NetworkDisconnected());
      } else {
        emit(NetworkConnected());
      }
    });
  }
}
