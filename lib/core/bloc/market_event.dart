
import 'package:equatable/equatable.dart';

abstract class MarketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMarketData extends MarketEvent {}
