import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/repositories/cong_viec_respository.dart';

part 'list_statistical_page_event.dart';

part 'list_statistical_page_state.dart';

class ListStatisticalPageBloc
    extends Bloc<ListStatisticalPageEvent, ListStatisticalPageState> {
  List<CongViec> listTask = [];

  ListStatisticalPageBloc() : super(ListStatisticalPageInitial()) {
    CongViecRepository congViecRepository = CongViecRepository();
    on<ListStatisticalPageEvent>((event, emit) async {
      if (event is GetListStatisticalTaskEvent) {
        emit(ListStatisticalPageLoading());
        try {
          listTask =
              await congViecRepository.getAllTaskWithStatus(event.trangThai);
          if (listTask.isNotEmpty) {
            emit(ListStatisticalPageLoaded(listTask: listTask));
          } else {
            emit(ListStatisticalEmpty());
          }
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(ListStatisticalPageError(error: e.response?.data));
          } else {
            emit(ListStatisticalPageError(error: e.toString()));
          }
        }
      }
    });
  }
}
