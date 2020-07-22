import 'package:flutter_test/flutter_test.dart';
import 'package:movie_imdb_like_app/blocs/home/bloc.dart';

void main() {
  test('Valid text to search movies', () async  {

    HomeBloc homeBloc=HomeBloc();  
    String query='Steve Jobs';
    homeBloc.queryTextEditingController.text=query;
    homeBloc.queryStreamSink.add(query);
    homeBloc.add(FetchSearchMoviesEvent());
    Future.delayed(Duration.zero, ()  {
      expectAsync0(() {
        expect(homeBloc.searchMoviesList.length>0, true); 
        homeBloc.dispose();
        homeBloc.close();
      });
    });
  });
  test('Blank text to search movies', () async  {

    HomeBloc homeBloc=HomeBloc();  
    homeBloc.queryStreamSink.add('');
    homeBloc.add(FetchSearchMoviesEvent());
    Future.delayed(Duration.zero, ()  {
      expectAsync0(() {
      expect(homeBloc.searchMoviesList, []);

      homeBloc.dispose();
      homeBloc.close();
     });
  });
  });
}