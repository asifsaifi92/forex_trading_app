import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm_forex_tracker/core/bloc/forex_bloc.dart';
import 'package:fxtm_forex_tracker/core/bloc/forex_state.dart';
import 'package:fxtm_forex_tracker/data/repositories/forex_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class MockForexRepository extends Mock implements ForexRepository {}
class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late ForexBloc forexBloc;
  late MockForexRepository mockRepository;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockRepository = MockForexRepository();
    mockConnectivity = MockConnectivity();
    forexBloc = ForexBloc(forexRepository: mockRepository, connectivity: mockConnectivity);
  });

  tearDown(() {
    forexBloc.close();
  });

  group('ForexBloc', () {
    test('initial state should be ForexInitial', () {
      expect(forexBloc.state, equals(ForexInitial()));
    });

    blocTest<ForexBloc, ForexState>(
        'emits [ForexLoading, ForexLoaded] when data is fetched successfully',
        build: () {
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);
      when(() => mockRepository.getLiveForexData(any())).thenAnswer((_) async => [
        ForexPrice(symbol: "EUR/USD", price: 1.12, change: 0.01),
      ]);
      return forexBloc;
    },
  act:
