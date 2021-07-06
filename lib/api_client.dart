import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currencyURL = Uri.https("api.currconv.com", "/api/v7/currencies", {"apiKey": "da4a5b25eb1b4ec089509f4b8f3b530e"});

  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currencyURL);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["results"];
      List<String> currencies = (list.keys).toList();
      print(currencies);
      return currencies;
    } else {
      throw Exception('Problema para concectar para a API');
    }
  }

  Future<double> getRate(String from, String to) async {
    final Uri rateUrl = Uri.https("api.currconv.com", "/api/v7/convert", {"apiKey": "da4a5b25eb1b4ec089509f4b8f3b530e", 
      "q" : "${from}_${to}",
      "compact": "ultra"
    });
    http.Response res = await http.get(rateUrl);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      return body['${from}_${to}'];
    }else{
      throw Exception('Problema para conectar a API');
    }
  }
}