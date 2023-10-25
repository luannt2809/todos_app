
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/repositories/cong_viec_respository.dart';

part 'list_transfer_task_page_event.dart';
part 'list_transfer_task_page_state.dart';

class ListTransferTaskPageBloc extends Bloc<ListTransferTaskPageEvent, ListTransferTaskPageState> {
  List<CongViec> listTransferTask = [];

  ListTransferTaskPageBloc() : super(ListTransferTaskPageInitial()) {
    on<ListTransferTaskPageEvent>((event, emit) async {
      CongViecRepository congViecRepository = CongViecRepository();
      if(event is GetListTransferTaskEvent){
        emit(ListTransferTaskPageLoading());
        try {
          listTransferTask = await congViecRepository.getAllTransferTask(event.maCV);
          if(listTransferTask.isNotEmpty){
            emit(ListTransferTaskPageLoaded(listTransferTask: listTransferTask));
          } else {
            emit(GetListTransferTaskEmpty());
          }
        } on DioException catch(e) {
          if(e.type == DioExceptionType.badResponse){
            emit(ListTransferTaskPageError(error: e.response?.data));
          } else {
            emit(ListTransferTaskPageError(error: e.toString()));
          }
        }
      }
    });
  }
}
