abstract class ForexState {}

class ForexInitial extends ForexState {}

class ForexLoading extends ForexState {}

class ForexLoaded extends ForexState {
  final String symbol;  // Currency pair symbol (e.g., EUR/USD)
  final double price;   // Current price
  final double previousPrice;  // Previous price for comparison

  ForexLoaded(this.symbol, this.price, this.previousPrice);
}

class ForexError extends ForexState {
  final String message;

  ForexError(this.message);
}
