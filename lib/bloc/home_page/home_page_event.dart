part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

// class GetTaskList extends HomePageEvent {
//   final String startDate;
//   final String inputTime;
//
//   const GetTaskList({required this.startDate, required this.inputTime});
//
// }

class GetTaskList extends HomePageEvent {
  final String startDate;

  const GetTaskList({required this.startDate});

}
