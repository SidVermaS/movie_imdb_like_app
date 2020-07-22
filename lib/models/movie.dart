class Movie {
  int id;
  double vote_average;
  String title,poster_path,backdrop_path,release_date,overview;
  Movie({this.id, this.backdrop_path});
  Movie.fromJsonHome(Map<String, dynamic> map)  {
    id=map['id'];
    title=map['title'];
    poster_path=map['poster_path']==null?map['backdrop_path']==null?'':map['backdrop_path'].substring(0):map['poster_path'].substring(0);
    release_date=map['release_date'];
  }

   Movie.fromJsonDetails(Map<String, dynamic> map)  {
    id=map['id'];
    vote_average=map['vote_average'];
    title=map['title'];
    poster_path=map['poster_path']==null?map['backdrop_path']==null?'':map['backdrop_path'].substring(0):map['poster_path'].substring(0);
    backdrop_path=map['backdrop_path']==null?map['poster_path']==null?'':map['poster_path'].substring(0):map['backdrop_path'].substring(0);
    overview=map['overview'];
    release_date=map['release_date'];
  }
}