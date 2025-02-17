class ForexPair {
  final String symbol;
  final String base;
  final String quote;
  final double price;
  final double priceChange;

  ForexPair({
    required this.symbol,
    required this.base,
    required this.quote,
    required this.price,
    required this.priceChange,
  });

  factory ForexPair.fromJson(Map<String, dynamic> json) {
    return ForexPair(
      symbol: json['s'] ?? '',
      base: json['s']?.split('/').first ?? '',
      quote: json['s']?.split('/').last ?? '',
      price: (json['p'] as num?)?.toDouble() ?? 0.0,
      priceChange: (json['d'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
