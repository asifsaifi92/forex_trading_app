import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/forex_repository.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final ForexRepository repository;

  HistoryBloc({required this.repository}) : super(HistoryInitial()) {
    on<FetchHistory>(_onFetchHistory);
  }

  Future<void> _onFetchHistory(FetchHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading()); // Show loading state

    try {
      final historyData = await repository.getHistoricalData(event.symbol);
      emit(HistoryLoaded(historyData)); // Success - Emit historical data
    } catch (e) {
      emit(HistoryError("Failed to load data: ${e.toString()}")); // Handle errors
    }
  }
}
