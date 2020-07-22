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

import 'package:movie_imdb_like_app/blocs/home/bloc.dart';
import 'package:movie_imdb_like_app/models/movie.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc():super(null);
  
  HomeState get initialState=>HomeInitialState(); 
  final TextEditingController queryTextEditingController=TextEditingController();
  final ScrollController scrollController=ScrollController();
  final BehaviorSubject<String> queryBehaviorSubject=BehaviorSubject<String>();
  Stream<String> get queryStream=>queryBehaviorSubject.stream;
  StreamSink<String> get queryStreamSink=>queryBehaviorSubject.sink;
  AppWidgets appWidgets=AppWidgets();
  ConvertDate convertDate=ConvertDate();
  void dispose()  {
    queryBehaviorSubject.close();
    queryTextEditingController.dispose();
    scrollController.dispose();
  }

  bool notLoading=true, notSearchLoading=true;
  int page=0, searchPage=0;
  List<Movie> moviesList=List<Movie>(),searchMoviesList=List<Movie>(); 
  Map<String, dynamic> bodyMap;
  URLQueryParams queryParams=URLQueryParams();
  Stream<HomeState> mapEventToState(HomeEvent event) async* {   
      
      if(event is FetchMoviesEvent)  { 
        yield* mapMoviesEventToState(event);
      } else if(event is FetchSearchMoviesEvent) {
        yield* mapSearchEventToState(event);
      } else if(event is ClearSearchMoviesEvent)  {
        yield* mapClearSearchEventToState(event);
      }
  }

  Stream<HomeState> mapMoviesEventToState(FetchMoviesEvent event) async* {
      if(notLoading)  {
          notLoading=false;
          try {
            page++;
            queryParams=URLQueryParams();
            queryParams.append('page', page);
            http.Response response=await Global.connect.sendGet('${ConstantSubUrls.getNowPlaying}?${queryParams.toString()}');
            Map<String, dynamic> mapResponse=jsonDecode(response.body);
    
            if(response.statusCode==200)  {
              List<dynamic> dynamicList=mapResponse['results'] as List<dynamic>; 
              
              dynamicList.map((i)=>moviesList.add(Movie.fromJsonHome(i))).toList();
              if(dynamicList.length==0) {
                page--;
              }
              yield HomeLoadedState(moviesList: moviesList);
             
            } else  {     
              page--;     
              yield HomeErrorState(message: mapResponse['message'], moviesList: moviesList);
              
            }
          } catch(e)  {
            page--;
             yield HomeErrorState(message: e.toString(), moviesList: moviesList);
          }
        notLoading=true;
        }      
  }
   Stream<HomeState> mapSearchEventToState(FetchSearchMoviesEvent event) async* {
     if(searchPage==0)  {
       notLoading=true;
     }
      if(notLoading)  {
          notLoading=false;
          try {
            searchPage++;
            queryParams=URLQueryParams();
            queryParams.append('query', queryBehaviorSubject.value);
            queryParams.append('page', searchPage);
            http.Response response=await Global.connect.sendGet('${ConstantSubUrls.searchMovies}?${queryParams.toString()}');
            Map<String, dynamic> mapResponse=jsonDecode(response.body);
    
            if(response.statusCode==200)  {
              List<dynamic> dynamicList=mapResponse['results'] as List<dynamic>; 
              
              dynamicList.map((i)=>searchMoviesList.add(Movie.fromJsonHome(i))).toList();
              if(dynamicList.length==0) {
                searchPage--;
              }
              yield HomeLoadedState(moviesList: searchMoviesList);
             
            } else  {     
              searchPage--;     
              yield HomeErrorState(message: mapResponse['message'], moviesList: searchMoviesList);
              
            }
          } catch(e)  {
            searchPage--;
            yield HomeErrorState(message: e.toString(), moviesList: searchMoviesList);
          }
        notLoading=true;
        }      
  }
   Stream<HomeState> mapClearSearchEventToState(ClearSearchMoviesEvent event) async* {
    searchMoviesList=List<Movie>(); 
    notLoading=true;
    searchPage=0;
    queryTextEditingController.text='';
    queryStreamSink.add('');
    scrollController.animateTo(0, duration: null, curve: null);
    yield HomeLoadedState(moviesList: moviesList);           
  }
}