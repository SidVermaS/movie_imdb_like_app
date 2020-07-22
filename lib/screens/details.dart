import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:movie_imdb_like_app/blocs/details/bloc.dart';
import 'package:movie_imdb_like_app/models/movie.dart';
import 'package:movie_imdb_like_app/networks/constant_base_urls.dart';
import 'package:movie_imdb_like_app/utils/global.dart';
import 'package:shimmer/shimmer.dart';

class Details extends StatefulWidget {
  Movie movie;
  Details({this.movie});
  _DetailsState createState()=>_DetailsState();
}

class _DetailsState extends State<Details>  {
   DetailsBloc detailsBloc;
  
  void initState()  {
    super.initState();
    detailsBloc=BlocProvider.of<DetailsBloc>(context);
    detailsBloc.appWidgets.context=context;
    detailsBloc.movie=widget.movie;
    detailsBloc.add(FetchDetailsEvent());
  }


  void dispose()  {
    super.dispose();
    detailsBloc.dispose();
    detailsBloc.close();
  }


  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).pop();
        },),
        backgroundColor: Colors.black87,
        centerTitle: false,
        title: Text('IMDB Movies', style: TextStyle(color: Colors.white,)),
        
      ),
    body:  Container(
         decoration: BoxDecoration(
        color: Colors.black,
      
        
      ),
      
        child: BlocListener<DetailsBloc, DetailsState>  (
          listener: (BuildContext context, DetailsState state) {
            if(state is DetailsErrorState)  {
              detailsBloc.appWidgets.showToast(state.message);
            }
          },
          child: BlocBuilder<DetailsBloc, DetailsState> (
            builder: (context, state)  {
           if(state is DetailsLoadedState) {
               return loadMovie(state.movie);
            }
            return detailsBloc.appWidgets.getCircularProgressIndicator();
          },)
        )
      )
 );
  }

  Widget loadMovie(Movie movie) {
    return Container(
       padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        image: DecorationImage(
          image: NetworkImage('${ConstantBaseUrls.baseImageUrl}${movie.backdrop_path}',),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop)
        ),
        
      ),
      child: ListView(
      children: <Widget>[       
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
            // width:Global.width,
            // height: Global.height-(Global.height*0.55),
            height: 250.0,
            width: 50,
             child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        image: '${ConstantBaseUrls.baseImageUrl}${movie.poster_path}',
        fit: BoxFit.fill
        
      )),
        Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
        SizedBox(height: 5.0,),
          Text(movie.overview, style: TextStyle(color: Colors.white, fontSize: 15.5, fontWeight: FontWeight.w200), textAlign: TextAlign.left,),
            SizedBox(height: 10.0,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
       
          Text(detailsBloc.convertDate.convertToMMMMMddyyyy(movie.release_date), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400), textAlign: TextAlign.left,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Icon(Icons.star, color: Colors.yellow),
            SizedBox(width: 2.5,),
            Text(movie.vote_average.toStringAsFixed(1), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400), textAlign: TextAlign.left,),

          ],)
    ],)







        

















      ],
    ));

  } 
}