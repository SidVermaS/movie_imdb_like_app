abstract class HomeEvent  {
  
}

class FetchMoviesEvent extends HomeEvent  {
  FetchMoviesEvent();

  List<Object> get props=>null;

}

class FetchSearchMoviesEvent extends HomeEvent  {
  FetchSearchMoviesEvent();

  List<Object> get props=>null;

}

class ClearSearchMoviesEvent extends HomeEvent  {
  ClearSearchMoviesEvent();

  List<Object> get props=>null;
}