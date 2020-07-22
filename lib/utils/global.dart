import 'dart:async';
import 'package:movie_imdb_like_app/networks/connect.dart';
import 'package:movie_imdb_like_app/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';

class Global  {
  static Connect connect=Connect();
  static SharedPrefManager sharedPrefManager=SharedPrefManager();
  
  static String currentScreenType = 'home';

  static double height=0.0, width=0.0;
}