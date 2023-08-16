import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String apiKey =
      "BbjNOt5TF8RxBsmIUunlw6T2e4DjjkSbsZIgqR99GUKYKZwAUY4adI04";
  final String curatedUrl = "https://api.pexels.com/v1/curated";
  final String searchUrl = "https://api.pexels.com/v1/search";

  Future<List<dynamic>> fetchCuratedWallpapers() async {
    final response = await http
        .get(Uri.parse(curatedUrl), headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      return json.decode(response.body)["photos"];
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }

  Future<List<dynamic>> searchWallpapers(String query) async {
    final response = await http.get(Uri.parse("$searchUrl?query=$query"),
        headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      return json.decode(response.body)["photos"];
    } else {
      throw Exception('Failed to search wallpapers');
    }
  }
}
