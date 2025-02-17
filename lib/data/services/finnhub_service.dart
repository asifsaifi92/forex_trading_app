import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FinnhubService {
  final String apiKey = dotenv.env['FINNHUB_API_KEY']!;
  final String baseUrl = "https://finnhub.io/api/v1/quote";

  // Fetch and Cache Forex Price
  Future<Map<String, dynamic>> fetchForexPrice(String symbol) async {
    final box = await Hive.openBox('forex_cache');

    // Check if cached data exists
    if (box.containsKey(symbol)) {
      return box.get(symbol);
    }

    final response = await http.get(
      Uri.parse("$baseUrl?symbol=$symbol&token=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Cache the fetched data
      await box.put(symbol, data);
      return data;
    } else {
      throw Exception("Failed to fetch forex price");
    }
  }
}
