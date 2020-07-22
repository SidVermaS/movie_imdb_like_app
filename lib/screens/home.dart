import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:movie_imdb_like_app/blocs/home/bloc.dart';
import 'package:movie_imdb_like_app/models/movie.dart';
import 'package:movie_imdb_like_app/networks/constant_base_urls.dart';
import 'package:movie_imdb_like_app/utils/global.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  _HomeState createState()=>_HomeState();
}

class _HomeState extends State<Home>  {
   HomeBloc homeBloc;
  
  void initState()  {
    super.initState();
    Future.delayed(Duration.zero,() {
    Global.width=MediaQuery.of(context).size.width;
    Global.height=MediaQuery.of(context).size.height;
    });
    homeBloc=BlocProvider.of<HomeBloc>(context);
    homeBloc.appWidgets.context=context;

    homeBloc.add(FetchMoviesEvent());
  }


  void dispose()  {
    super.dispose();
    homeBloc.dispose();
    homeBloc.close();
  }


  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextField(
          onChanged: (String value) {
            homeBloc.queryStreamSink.add(value);
          },
          controller: homeBloc.queryTextEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
           prefixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {
             
             homeBloc.add(FetchSearchMoviesEvent());
           },) ,
          suffixIcon:  IconButton(icon: Icon(Icons.close), onPressed: () {
             homeBloc.add(ClearSearchMoviesEvent());
           },) 
           
          ),
        )









      ),
    body:  Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: BlocListener<HomeBloc, HomeState>  (
          listener: (BuildContext context, HomeState state) {
            if(state is HomeErrorState)  {
              homeBloc.appWidgets.showToast(state.message);
            }
          },
          child: BlocBuilder<HomeBloc, HomeState> (
            builder: (context, state)  {
            if(state is HomeInitialState) {
              return loadShimmer();
            }
            else if(state is HomeLoadedState) {
               return loadMovies(state.moviesList);
            }else if(state is HomeErrorState)  {
               return loadMovies(state.moviesList);
            }
            return homeBloc.appWidgets.getCircularProgressIndicator();
          },)
        )
      )
 );
  }

  Widget loadMovies(List<Movie> moviesList) {
    return LazyLoadScrollView(
      onEndOfPage: ()=>homeBloc.add(FetchMoviesEvent()),
      scrollOffset: 80,
      child: ListView.builder(
      itemCount: moviesList.length,
      itemBuilder: (BuildContext context, int index) {
        return  Container(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              width:Global.width,
              height: Global.height-(Global.height*0.55),
             child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/esperanza.jpg',
        image: '${ConstantBaseUrls.baseImageUrl}${moviesList[index].poster_path}',
        fit: BoxFit.cover,
        height: 250.0,
      )),
           
             Container(
             margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children:<Widget>  [
            homeBloc.appWidgets.getName('${moviesList[index].vote_count} votes'),
           Container(
             margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
             child:  Text(moviesList[index].title, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
            
            ]))
          ]));
      },
    ));














  } 
    Widget loadShimmer()  {
    return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: false,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 5), height: 195, width: double.infinity,color: Colors.white),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 50, width: double.infinity,
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                            // Container(width: 40, height: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white), ),
                            Container(margin: EdgeInsets.only(left: 10),width: 180, height: 20,color: Colors.white),
                          ],)
                        ),
                      
                    ],)
                  )
                  
                ),
              );
  }
}