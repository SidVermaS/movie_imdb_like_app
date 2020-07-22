import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_imdb_like_app/utils/global.dart';
import 'package:movie_imdb_like_app/networks/constant_base_urls.dart';
import 'package:http/http.dart' as http;

class Connect {
  Connect() {
  }  

  Future<http.Response> sendGet(String url) async {
    print(
        '~~~ url: ${ConstantBaseUrls.baseUrl}$url&api_key=${ConstantBaseUrls.apiKey}');
    http.Response response = await http.get('${ConstantBaseUrls.baseUrl}$url&api_key=${ConstantBaseUrls.apiKey}',);
    print('~~~ statusCode: ${response.statusCode}');
    debugPrint('~~~ response: ${response.body}');
    return response;
  }
}