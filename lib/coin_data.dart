import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String apiUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/";

class CoinData {
  Future getCoinPrice(String original, String coin) async {
    String url = '$apiUrl$original$coin';

    http.Response response = await http.get("$url");

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(decodedData["last"]);
      return decodedData["last"];
    }


  }
}
