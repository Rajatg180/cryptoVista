import 'dart:convert';
import 'package:http/http.dart' as http;

class API{

  static Future<List<dynamic>> getMarkets() async {
    try{
      Uri requestPath = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");
      var response = await http.get(requestPath);
      print('API Response: ${response.body}'); // Debug print statement
      var decodedResponse = jsonDecode(response.body);

      if (decodedResponse is List) {
        return List<dynamic>.from(decodedResponse);
      } else {
        throw Exception("Invalid response format");
      }
    }
    catch(ex){
      return [];
    }
  }

  static Future<List<dynamic>> fetchGraphData(String id, int days) async {
    try {
      Uri requestPath = Uri.parse("https://api.coingecko.com/api/v3/coins/${id}/market_chart?vs_currency=inr&days=${days}");

      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> prices = decodedResponse["prices"];
      return prices;
    } catch(ex) {
      return [];
    }
  }

  static Future<List<dynamic>> fetchNewsData()async{
    try{
      Uri requestPath= Uri.parse("https://newsapi.org/v2/everything?q=crypto&apiKey=1afa2a8d8cb34b919e86750df520ee03");

      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> news=decodedResponse['articles'];
      print(news);
      return news;

    }catch(ex){
      return [];
    }

  }


}
