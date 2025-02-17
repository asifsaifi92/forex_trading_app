import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fxtm_forex_tracker/presentation/pages/markets_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/bloc/forex_bloc.dart';
import 'core/bloc/forex_event.dart';
import 'core/network/network_cubit.dart';
import 'data/repositories/forex_repository.dart';
import 'data/services/finnhub_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider(create: (context) => NetworkCubit(Connectivity())),
        BlocProvider(
          create: (context) => ForexBloc(ForexRepository(FinnhubService()))
            ..add(FetchForexPrice(symbols: ['EUR/USD', 'GBP/USD', 'USD/JPY'])),
        ),
      ],
      child: MaterialApp(
        title: 'Forex Live Prices',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const MarketsScreen(),
      ),
    );
  }
}
