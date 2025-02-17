import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/forex_bloc.dart';
import '../../core/bloc/forex_event.dart';
import '../../core/bloc/forex_state.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  _MarketsScreenState createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ForexBloc>().add(FetchForexPrice(symbols: ['EUR/USD', 'GBP/USD', 'USD/JPY']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forex Live Prices')),
      body: Center(
        child: BlocBuilder<ForexBloc, ForexState>(
          builder: (context, state) {
            if (state is ForexLoading) {
              return const CircularProgressIndicator();
            } else if (state is ForexLoaded) {
              Color priceColor = state.price > state.previousPrice
                  ? Colors.green
                  : (state.price < state.previousPrice ? Colors.red : Colors.white);

              return ListView(
                children: [
                  ListTile(
                    title: Text(state.symbol),
                    subtitle: Text("\$${state.price.toStringAsFixed(4)}"),
                    trailing: Text(
                      state.price > state.previousPrice ? "Up" : "Down",
                      style: TextStyle(color: priceColor),
                    ),
                  ),
                ],
              );
            } else if (state is ForexError) {
              return Text("Error: ${state.message}");
            }
            return const Text("Fetching data...");
          },
        ),
      ),
    );
  }
}
