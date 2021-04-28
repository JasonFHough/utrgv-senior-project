// import 'package:flutter_driver/driver_extension.dart';
// import 'package:bitcoin_calculator/main.dart' as app;
// import 'package:bitcoin_calculator/config/globals.dart' as globals;
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;

// class MockClient extends Mock implements http.Client {}

// void main() {
//   // This line enables the extension.
//   enableFlutterDriverExtension();

//   final MockClient client = MockClient();

//   final fakeRateAPIData =
//       '{"time":{"updated":"Nov 13, 2020 20:09:00 UTC","updatedISO":"2020-11-13T20:09:00+00:00","updateduk":"Nov 13, 2020 at 20:09 GMT"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,420.00","description":"United States Dollar","rate_float":69420.00}}}';
//   when(client.get(
//           'https://api.coindesk.com/v1/bpi/currentprice/usd.json?escape=javascript'))
//       .thenAnswer((_) async => http.Response(fakeRateAPIData, 200));

//   globals.httpClient = client;
//   // Call the `main()` function of the app, or call `runApp` with
//   // any widget you are interested in testing.
//   app.main();
// }