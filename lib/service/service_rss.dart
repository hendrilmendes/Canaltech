import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed_revised/webfeed_revised.dart';

class RSSService {
  static Future<RssFeed?> loadFeed(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return RssFeed.parse(response.body);
      } else {
        throw Exception('Failed to load RSS feed');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading RSS feed: $e');
      }
      return null;
    }
  }
}
