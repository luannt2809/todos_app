part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<CongViec> taskList;

  const HomePageLoaded({required this.taskList});
}

class HomePageError extends HomePageState {
  final String? error;

  const HomePageError(this.error);
}

class GetListTaskEmpty extends HomePageState {

}