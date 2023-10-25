
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/models/log_cong_viec.dart';
import 'package:todos_app/services/repositories/log_cong_viec_repository.dart';

part 'list_log_task_page_event.dart';
part 'list_log_task_page_state.dart';

class ListLogTaskPageBloc extends Bloc<ListLogTaskPageEvent, ListLogTaskPageState> {
  List<LogCongViec> listLogCongViec = [];

  ListLogTaskPageBloc() : super(ListLogTaskPageInitial()) {
    on<ListLogTaskPageEvent>((event, emit) async {
      LogCongViecRepository logCongViecRepository = LogCongViecRepository();
      if(event is GetListLogTaskEvent){
        emit(ListLogTaskPageLoading());
        try {
          listLogCongViec = await logCongViecRepository.getListLogCongViec(event.maCV);
          if(listLogCongViec.isNotEmpty){
            emit(ListLogTaskPageLoaded(listLogCongViec: listLogCongViec));
          } else {
            emit(GetListLogCongViecEmpty());
          }
        } on DioException catch(e) {
          if(e.type == DioExceptionType.badResponse){
            emit(ListLogTaskPageError(error: e.response?.data));
          } else {
            emit(ListLogTaskPageError(error: e.toString()));
          }
        }
      }
    });
  }
}
