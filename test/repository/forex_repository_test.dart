import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'mocks/mock_http_client.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ForexRepository forexRepository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    forexRepository = ForexRepository(client: mockHttpClient);
  });

  test('Successfully fetches forex data', () async {
    // Define mock data
    final mockResponse = '''[
      {"symbol": "EUR/USD", "price": 1.22},
      {"symbol": "GBP/USD", "price": 1.38}
    ]''';

    when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(mockResponse, 200),
    );

    final result = await forexRepository.getLiveForexData(['EUR/USD', 'GBP/USD']);

    // Verify the data was correctly returned
    expect(result.length, 2);
    expect(result[0].symbol, 'EUR/USD');
    expect(result[1].symbol, 'GBP/USD');
  });


  test('Throws an error when API call fails', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response("Error", 500));

    // The request should throw an exception due to 500 error
    expect(
          () => forexRepository.getLiveForexData(['EUR/USD']),
      throwsException,
    );
  });


  //
  // setUp(() {
  //   mockHttpClient = MockHttpClient();
  //   mockConnectivity = Connectivity();
  //   forexRepository = ForexRepository(
  //     client: mockHttpClient,
  //     connectivity: mockConnectivity,
  //   );
  // });
  // test('Throws exception when offline', () async {
  //   // Mock the connectivity to simulate offline scenario
  //   when(mockConnectivity.checkConnectivity())
  //       .thenAnswer((_) async => ConnectivityResult.none);
  //
  //   // The request should throw an exception due to no internet connection
  //   expect(
  //         () => forexRepository.getLiveForexData(['EUR/USD']),
  //     throwsException,
  //   );
  // });


}
