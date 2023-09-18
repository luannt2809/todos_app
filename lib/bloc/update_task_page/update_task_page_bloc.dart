import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/services/repositories/cong_viec_respository.dart';

part 'update_task_page_event.dart';

part 'update_task_page_state.dart';

class UpdateTaskPageBloc
    extends Bloc<UpdateTaskPageEvent, UpdateTaskPageState> {
  UpdateTaskPageBloc() : super(UpdateTaskPageInitial()) {
    on<UpdateTaskPageEvent>((event, emit) async {
      CongViecRepository congViecRepository = CongViecRepository();
      if (event is UpdateTask) {
        emit(UpdateTaskPageLoading());
        try {
          Response response = await congViecRepository.updateTask(
              event.maCV,
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
            emit(UpdateTaskPageLoaded(response.data.toString()));
          }
        } catch (e) {
          emit(UpdateTaskPageError(error: 'Cập nhật thất bại: $e'));
        }
      }
    });
  }
}
