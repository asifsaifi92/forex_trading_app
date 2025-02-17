

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/testing.dart';


import '../models/forexHistoryData.dart';
import '../services/finnhub_service.dart';
import 'package:http/http.dart' as http;
class ForexRepository {
  final FinnhubService _service;

  ForexRepository(this._service, { MockClient? client});

  // Fetch forex price for multiple pairs
  Future<Map<String, dynamic>> getLatestForexPrice(String symbol) {
    return _service.fetchForexPrice(symbol);
  }

  Future<List<ForexHistoricalData>> getHistoricalData(String symbol) async {
    final String apiKey = dotenv.env['FINNHUB_API_KEY']!;

    final response = await http.get(
      Uri.parse("https://finnhub.io/api/v1/forex/candle?symbol=$symbol&resolution=D&count=30&token=$apiKey"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List.generate(
        data['t'].length,
            (index) => ForexHistoricalData(
          date: DateTime.fromMillisecondsSinceEpoch(data['t'][index] * 1000),
          price: data['c'][index].toDouble(),
        ),
      );
    } else {
      throw Exception("Failed to fetch historical data");
    }
  }
}


