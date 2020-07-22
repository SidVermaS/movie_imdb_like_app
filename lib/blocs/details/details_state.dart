import 'package:equatable/equatable.dart';
import 'package:movie_imdb_like_app/models/movie.dart';

abstract class DetailsState extends Equatable {

}

class DetailsInitialState extends DetailsState {

  List<Object> get props=>[];
}

class DetailsLoadedState extends DetailsState {
  Movie movie;

  DetailsLoadedState({this.movie});

  List<Object> get props=>[movie];
}
 

class DetailsErrorState extends DetailsState {
  String message;
   Movie movie;

  DetailsErrorState({this.movie, this.message});

  List<Object> get props=>[movie, message];
}





























