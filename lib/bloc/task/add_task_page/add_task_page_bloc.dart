import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/services/repositories/cong_viec_respository.dart';

part 'add_task_page_event.dart';

part 'add_task_page_state.dart';

class AddTaskPageBloc extends Bloc<AddTaskPageEvent, AddTaskPageState> {
  AddTaskPageBloc() : super(AddTaskPageInitial()) {
    on<AddTaskPageEvent>((event, emit) async {
      if (event is AddTask) {
        CongViecRepository congViecRepository = CongViecRepository();
        // implement event handler
        emit(AddTaskPageLoading());
        try {
          Response response = await congViecRepository.addTask(
              event.tieuDe,
              event.noiDung,
              event.ngayBD,
              event.ngayKT,
              event.gioBD,
              event.gioKT,
              event.trangThai,
              event.tienDo,
              event.ghiChu);
          if (response.statusCode == 200) {
            emit(AddTaskPageLoaded(response.data.toString()));
          }
        } on DioException catch (e) {
          if(e.type == DioExceptionType.badResponse){
            emit(AddTaskPageError(error: 'Error: ${e.response?.data}'));
          } else {
            emit(AddTaskPageError(error: e.toString()));
          }
        }
      }
    });
  }
}
