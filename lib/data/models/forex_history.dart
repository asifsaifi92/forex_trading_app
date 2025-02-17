class ForexHistory {
  final List<double> timestamps;
  final List<double> prices;

  ForexHistory({
    required this.timestamps,
    required this.prices,
  });

  factory ForexHistory.fromJson(Map<String, dynamic> json) {
    return ForexHistory(
      timestamps: List<double>.from(json['timestamps'].map((t) => t.toDouble())),
      prices: List<double>.from(json['prices'].map((p) => p.toDouble())),
    );
  }
}
