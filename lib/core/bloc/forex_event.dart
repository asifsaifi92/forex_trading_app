abstract class ForexEvent {}

class FetchForexPrice extends ForexEvent {
  final List<String> symbols; // List of currency pair symbols (e.g., ['EUR/USD', 'GBP/USD'])

  FetchForexPrice({required this.symbols});
}
