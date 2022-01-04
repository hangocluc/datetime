import 'package:equatable/equatable.dart';
abstract class DropDownState extends Equatable {
  const DropDownState();
}

class DropDownStateInitial extends DropDownState {
  @override
  List<Object> get props => [];
}

class Loading extends DropDownState {
  @override
  List<Object> get props => [];
}