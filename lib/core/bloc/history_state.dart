import '../../data/models/forexHistoryData.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<ForexHistoricalData> historyData;
  HistoryLoaded(this.historyData);
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}
