import 'package:movie_imdb_like_app/models/movie.dart';

abstract class HomeState  {

}

class HomeInitialState extends HomeState {

  List<Object> get props=>[];
}

class HomeLoadedState extends HomeState {
  List<Movie> moviesList=List<Movie>();

  HomeLoadedState({this.moviesList});

  List<Object> get props=>[moviesList];
}

class HomeSearchLoadedState extends HomeState {
  List<Movie> moviesList=List<Movie>();

  HomeSearchLoadedState({this.moviesList});

  List<Object> get props=>[moviesList];
}  

class HomeErrorState extends HomeState {
  String message;
  List<Movie> moviesList=List<Movie>();

  HomeErrorState({this.moviesList, this.message});

  List<Object> get props=>[moviesList, message];
}





























