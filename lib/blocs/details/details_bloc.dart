import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_imdb_like_app/networks/constant_sub_urls.dart';
import 'package:movie_imdb_like_app/utils/app_widgets.dart';
import 'package:movie_imdb_like_app/utils/convert_date.dart';
import 'package:movie_imdb_like_app/utils/global.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:query_params/query_params.dart';

import 'package:movie_imdb_like_app/blocs/details/bloc.dart';
import 'package:movie_imdb_like_app/models/movie.dart';
import 'package:rxdart/rxdart.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {

  DetailsBloc():super(null);
  
  DetailsState get initialState=>DetailsInitialState(); 

  AppWidgets appWidgets=AppWidgets();
  ConvertDate convertDate=ConvertDate();
  void dispose()  {
  }

  Movie movie; 
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {   
      
      if(event is FetchDetailsEvent)  { 
        yield* mapDetailsDetailsEventToState(event);
      }
  }
   Stream<DetailsState> mapDetailsDetailsEventToState(FetchDetailsEvent event) async* {
    try  {
      http.Response response=await Global.connect.sendGet('${ConstantSubUrls.movie}/${movie.id}?');
      Map<String, dynamic> mapResponse=jsonDecode(response.body);

      if(response.statusCode==200)  {
        movie=Movie.fromJsonDetails(mapResponse);

        yield DetailsLoadedState(movie: movie); 
        
      } else  {      
        yield DetailsErrorState(message: mapResponse['status_message']);
        
      }
         
    } catch(e)  {
      yield DetailsErrorState(message: e.toString());
    }       
  }
}