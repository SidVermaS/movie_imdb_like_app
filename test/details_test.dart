import 'package:flutter_test/flutter_test.dart';
import 'package:movie_imdb_like_app/blocs/details/bloc.dart';
import 'package:movie_imdb_like_app/models/movie.dart';

void main() { 
  test('Valid ID of a movie', () async {

    DetailsBloc detailsBloc=DetailsBloc();

    detailsBloc.movie=Movie(id: 321697);
    detailsBloc.add(FetchDetailsEvent());
    print('~~~ movie: ${detailsBloc.movie} ${detailsBloc.movie.title}');
    Future.delayed(Duration.zero, ()  {
      expectAsync0(() {
      expect(detailsBloc.movie.title, 'Steve Jobs');

      detailsBloc.dispose();
      detailsBloc.close();
     });
    });
  });

  test('Invalid ID of a movie', () async {

    DetailsBloc detailsBloc=DetailsBloc();

    detailsBloc.movie=Movie(id: -99);
    detailsBloc.add(FetchDetailsEvent());
    Future.delayed(Duration.zero, ()  {
      expectAsync0(() {
      expect(detailsBloc.movie.title, null);

      detailsBloc.dispose();
      detailsBloc.close();
     });
    });
  });
}