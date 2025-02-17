import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fxtm_forex_tracker/core/network/network_cubit.dart';


void main() {
  testWidgets('Displays No Internet Connection when offline', (tester) async {
    // Set initial state as disconnected
    final networkCubit = NetworkCubit(Connectivity());
    networkCubit.emit(NetworkDisconnected());

    await tester.pumpWidget(
      BlocProvider.value(
        value: networkCubit,
        child: MaterialApp(home: NetworkStatusWidget()),
      ),
    );

    // Verify UI shows "No Internet Connection"
    expect(find.text('No Internet Connection'), findsOneWidget);
  });

  testWidgets('Does not display No Internet Connection when online', (tester) async {
    // Set initial state as connected
    final networkCubit = NetworkCubit(Connectivity());
    networkCubit.emit(NetworkConnected());

    await tester.pumpWidget(
      BlocProvider.value(
        value: networkCubit,
        child: MaterialApp(home: NetworkStatusWidget()),
      ),
    );

    // Verify UI does not show "No Internet Connection"
    expect(find.text('No Internet Connection'), findsNothing);
  });
}
