import 'package:equatable/equatable.dart';
import '../../data/models/forex_pair.dart';

abstract class MarketState extends Equatable {
  @override
  List<Object> get props => [];
}

class MarketInitial extends MarketState {}
class MarketLoading extends MarketState {}
class MarketLoaded extends MarketState {
  final List<ForexPair> forexPairs;
  MarketLoaded(this.forexPairs);
  @override
  List<Object> get props => [forexPairs];
}
class MarketError extends MarketState {
  final String message;
  MarketError(this.message);
  @override
  List<Object> get props => [message];
}
