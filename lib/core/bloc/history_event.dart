abstract class HistoryEvent {}

class FetchHistory extends HistoryEvent {
  final String symbol;
  FetchHistory(this.symbol);
}
