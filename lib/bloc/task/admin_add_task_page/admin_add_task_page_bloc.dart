import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/services/repositories/cong_viec_respository.dart';

part 'admin_add_task_page_event.dart';

part 'admin_add_task_page_state.dart';

class AdminAddTaskPageBloc
    extends Bloc<AdminAddTaskPageEvent, AdminAddTaskPageState> {
  AdminAddTaskPageBloc() : super(AdminAddTaskPageInitial()) {
    on<AdminAddTaskPageEvent>((event, emit) async {
      if (event is AdminAddTaskEvent) {
        CongViecRepository congViecRepository = CongViecRepository();
        emit(AdminAddTaskPageLoading());
        try {
          Response response = await congViecRepository.adminAddTask(
              event.tieuDe,
              event.noiDung,
              event.ngayBD,
              event.ngayKT,
              event.gioBD,
              event.gioKT,
              event.trangThai,
              event.tienDo,
              event.ghiChu,
              event.maNguoiLam,
              event.maNguoiGiao,
              event.kieu);
          if (response.statusCode == 200) {
            emit(AdminAddTaskPageLoaded(response.data.toString()));
          }
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(AdminAddTaskPageError(e.response?.data));
          } else {
            emit(AdminAddTaskPageError(e.toString()));
          }
        }
      }
    });
  }
}
