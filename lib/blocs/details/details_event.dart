import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  
}

class FetchDetailsEvent extends DetailsEvent  {
  FetchDetailsEvent();

  List<Object> get props=>null;

}
