import 'package:equatable/equatable.dart';

abstract class ShowDateState extends Equatable {
  const ShowDateState();
}

class ShowDateStateInitial extends ShowDateState {
  @override
  List<Object> get props => [];
}

class Loading extends ShowDateState {
  @override
  List<Object> get props => [];
}
