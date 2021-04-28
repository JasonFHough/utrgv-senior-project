// // Imports the Flutter Driver API.
// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:test/test.dart';

// void main() {
//   final usd = find.byValueKey('usdButton');
//   final btc = find.byValueKey('btcButton');
//   final usdollarsText = find.byValueKey('usdText');
//   final bitcoinText = find.byValueKey('btcText');
//   final usConvert = find.byValueKey('usdConvert');
//   final bitConvert = find.byValueKey('btcConvert');
//   final usResult = find.byValueKey('usdResult');
//   final bitResult = find.byValueKey('btcResult');

//   FlutterDriver driver;

//   // Connect to the Flutter driver before running any tests.
//   setUpAll(() async {
//     driver = await FlutterDriver.connect();
//   });

//   // Close the connection to the driver after the tests have completed.
//   tearDownAll(() async {
//     if (driver != null) {
//       driver.close();
//     }
//   });

//   group('Happy paths', () {
//     test("convert 1 Dollar to Bitcoins", () async {
//       //when I tap USD to BTC button
//       await driver.tap(usd);
//       //and I enter 1 in the text field
//       await driver.tap(usdollarsText);
//       await driver.enterText('1');
//       await driver.waitFor(find.text('1'));
//       //Then I should see "1.0 Dollar is 0.000014405070584845865 Bitcoins"
//       Future.delayed(const Duration(seconds: 1));
//       await driver.tap(usConvert);
//       expect(await driver.getText(usResult),
//           "1.0 Dollar is 0.000014405070584845865 Bitcoins");
//       await driver.tap(find.byTooltip('Back'));
//       await driver.tap(find.byTooltip('Back'));
//     });
//     test("convert 1 Bitcoin to Dollars", () async {
//       //when I tap BTC to USD button
//       await driver.tap(btc);
//       //and I enter 1 in the text field
//       await driver.tap(bitcoinText);
//       await driver.enterText('1');
//       await driver.waitFor(find.text('1'));
//       //Then I should see "1.0 Bitcoin is 69420.0 Dollars"
//       Future.delayed(const Duration(seconds: 1));
//       await driver.tap(bitConvert);
//       expect(await driver.getText(bitResult), "1.0 Bitcoin is 69420.0 Dollars");
//     });
//   });

//   group('Sad paths', () {
//     /*
//       When I'm on the dollars screen and press the convert button without having 
//       put in an amount, I should still be in the dollars screen
//     */
//     test("Should not advance to dollar result screen without amount", () async {
//       await driver.tap(usd);
//       Future.delayed(const Duration(seconds: 1));
//       await driver.tap(usConvert);
//       Future.delayed(const Duration(seconds: 1));
//       await driver.waitFor(find.text('No Dollars to convert!'));
//       await driver.tap(find.byTooltip('Back'));
//     });
//     /*
//       When I'm on the bitcoin screen and press the convert button without having 
//       put in an amount, I should still be in the bitcoin screen
//     */
//     test("Should not advance to bitcoin result screen without amount",
//         () async {
//       await driver.tap(btc);
//       Future.delayed(const Duration(seconds: 1));
//       await driver.tap(bitConvert);
//       Future.delayed(const Duration(seconds: 1));
//       await driver.waitFor(find.text('No Bitcoins to convert!'));
//       await driver.tap(find.byTooltip('Back'));
//     });
//     /*
//       When I'm on the bitcoin screen and press the back button, it should take me back to the main screen
//     */
//     test(
//         "Back button should take me back to the previous page from Bitcoin Conversion",
//         () async {
//       await driver.tap(btc);
//       Future.delayed(const Duration(seconds: 1));
//       await driver.tap(find.byTooltip('Back'));
//       Future.delayed(const Duration(seconds: 1));
//       await driver.waitFor(find.text("BTC-USD Conversion"));
//     });

//     /*
//       When I'm on the dollar screen and press the back button, it should take me back to the main screen
//     */
//     test(
//         "Back button should take me back to the previous page from Dollar Conversion",
//         () async {
//       await driver.tap(usd);
//       Future.delayed(const Duration(seconds: 1));
//       await driver.tap(find.byTooltip('Back'));
//       Future.delayed(const Duration(seconds: 1));
//       await driver.waitFor(find.text("BTC-USD Conversion"));
//     });
//   });
// }