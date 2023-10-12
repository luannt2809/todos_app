part of 'list_statistical_page_bloc.dart';

@immutable
abstract class ListStatisticalPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListStatisticalPageInitial extends ListStatisticalPageState {}

class ListStatisticalPageLoading extends ListStatisticalPageState {}

class ListStatisticalPageLoaded extends ListStatisticalPageState {
  final List<CongViec> listTask;

  ListStatisticalPageLoaded({required this.listTask});
}

class ListStatisticalPageError extends ListStatisticalPageState {
  final String? error;

  ListStatisticalPageError({this.error});
}

class ListStatisticalEmpty extends ListStatisticalPageState {}
