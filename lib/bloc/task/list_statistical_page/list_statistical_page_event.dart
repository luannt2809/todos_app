part of 'list_statistical_page_bloc.dart';

@immutable
abstract class ListStatisticalPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListStatisticalTaskEvent extends ListStatisticalPageEvent {
  final String trangThai;

  GetListStatisticalTaskEvent({required this.trangThai});
}
