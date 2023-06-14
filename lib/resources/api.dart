import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/song.dart';

class API {
  static const String baseURL = "c340-103-242-199-226.ngrok-free.app";

  static Future<dynamic> getNewReleases() async {
    var url = Uri.https(baseURL, 'newReleases');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Song> songs = json
          .decode(response.body)
          .map((s) => Song.fromJson(s))
          .toList()
          .cast<Song>();

      return songs;
    }

    return "Error";
  }
}
