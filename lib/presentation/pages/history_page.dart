import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../core/bloc/forex_chart.dart';
import '../../core/bloc/history_bloc.dart';
import '../../core/bloc/history_event.dart';
import '../../core/bloc/history_state.dart';
import '../../data/repositories/forex_repository.dart';
import '../../data/services/finnhub_service.dart';


class HistoryPage extends StatelessWidget {
  final String symbol; // Selected currency pair

  const HistoryPage({Key? key, required this.symbol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historical Data - $symbol')),
      body: BlocProvider(
        create: (context) => HistoryBloc(repository: ForexRepository(FinnhubService()))..add(FetchHistory(symbol)),
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(child: ForexChart(state.historyData)),
                  ],
                ),
              );
            } else if (state is HistoryError) {
              return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
            }
            return const Center(child: Text("No Data Available"));
          },
        ),
      ),
    );
  }
}
