
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/repositories/cong_viec_respository.dart';

part 'list_task_assigned_page_event.dart';
part 'list_task_assigned_page_state.dart';

class ListTaskAssignedPageBloc extends Bloc<ListTaskAssignedPageEvent, ListTaskAssignedPageState> {
  List<CongViec> listTaskAssigned = [];

  ListTaskAssignedPageBloc() : super(ListTaskAssignedPageInitial()) {
    on<ListTaskAssignedPageEvent>((event, emit) async {
      CongViecRepository congViecRepository = CongViecRepository();
      if(event is GetListTaskAssigned){
        emit(ListTaskAssignedPageLoading());
        try {
          listTaskAssigned = await congViecRepository.getAllTaskAssigned(event.trangThai);
          if(listTaskAssigned.isNotEmpty){
            emit(ListTaskAssignedPageLoaded(listTaskAssigned: listTaskAssigned));
          } else {
            emit(ListTaskAssignedPageEmpty());
          }
        } on DioException catch (e){
          if(e.type == DioExceptionType.badResponse){
            emit(ListTaskAssignedPageError(error: e.response?.data));
          } else {
            emit(ListTaskAssignedPageError(error: e.toString()));
          }
        }
      }
    });
  }
}
