import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/forex_repository.dart';
import 'forex_event.dart';
import 'forex_state.dart';


class ForexBloc extends Bloc<ForexEvent, ForexState> {
  final ForexRepository repository;
  Timer? _timer;
  final Map<String, double> _previousPrices = {};

  ForexBloc(this.repository) : super(ForexInitial()) {
    on<FetchForexPrice>((event, emit) async {
      emit(ForexLoading()); // Emit loading state before fetching

      _timer?.cancel(); // Cancel any existing timer

      _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
        for (var symbol in event.symbols) {
          try {
            final data = await repository.getLatestForexPrice(symbol);
            final double price = (data["c"] as num).toDouble(); // Current price
            final previousPrice = _previousPrices[symbol] ?? price; // Get previous price

            if (!emit.isDone) {
              emit(ForexLoaded(symbol, price, previousPrice)); // ✅ Ensure Bloc is active
            }
            _previousPrices[symbol] = price;
          } catch (e) {
            if (!emit.isDone) {
              emit(ForexError(e.toString())); // ✅ Ensure Bloc is active
            }
          }
        }
      });
    });

  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
