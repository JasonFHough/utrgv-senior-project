// import 'package:test/test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mobile_app/Utils/apiData.dart';
// import 'package:http/http.dart' as http;

// class MockClient extends Mock implements http.Client {}

// void main() {
// //Dollar unit tests
//   group('Unit tests', () {
//     test('throws ArgumentError on zero dollars', () {
//       expect(() => ConversionTools.dollarsToBitcoins(0, rate),
//           throwsArgumentError);
//     });

//     test('returns conversion if more than zero dollars', () async {
//       final client = MockClient();
//       final fakeRateAPIData =
//           '{"time":{"updated":"Nov 13, 2020 20:09:00 UTC","updatedISO":"2020-11-13T20:09:00+00:00","updateduk":"Nov 13, 2020 at 20:09 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,420.00","description":"United States Dollar","rate_float":69420.00}}}';
//       when(client.get(
//               'https://api.coindesk.com/v1/bpi/currentprice/usd.json?escape=javascript'))
//           .thenAnswer((_) async => http.Response(fakeRateAPIData, 200));
//       double futureRate = await BTCAPI.fetchRate(client);
//       double dollar = ConversionTools.dollarsToBitcoins(1.0, futureRate);
//       expect(dollar, 69420.0);
//     });

// //Bitcoin unit tests
//     test('throws ArgumentError on zero bitcoins', () {
//       expect(() => ConversionTools.bitcoinsToDollars(0, rate),
//           throwsArgumentError);
//     });
//     test('returns conversion if more than zero bitcoins', () async {
//       final client = MockClient();
//       final fakeRateAPIData =
//           '{"time":{"updated":"Nov 13, 2020 20:09:00 UTC","updatedISO":"2020-11-13T20:09:00+00:00","updateduk":"Nov 13, 2020 at 20:09 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,420.00","description":"United States Dollar","rate_float":69420.00}}}';
//       when(client.get(
//               'https://api.coindesk.com/v1/bpi/currentprice/usd.json?escape=javascript'))
//           .thenAnswer((_) async => http.Response(fakeRateAPIData, 200));
//       double futureRate = await BTCAPI.fetchRate(client);
//       double bitcoin = ConversionTools.bitcoinsToDollars(1.0, futureRate);
//       expect(bitcoin, 0.000014405070584845865);
//     });
//   });
// }