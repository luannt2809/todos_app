
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/services/repositories/phong_ban_repository.dart';

part 'update_department_event.dart';

part 'update_department_state.dart';

class UpdateDepartmentBloc
    extends Bloc<UpdateDepartmentEvent, UpdateDepartmentState> {
  UpdateDepartmentBloc() : super(UpdateDepartmentInitial()) {
    on<UpdateDepartmentEvent>((event, emit) async {
      PhongBanRepository phongBanRepository = PhongBanRepository();
      if (event is UpdateDepartment) {
        emit(UpdatingDepartment());
        try {
          Response response = await phongBanRepository.updateDepartment(
              event.maPB, event.tenPB);
          if (response.statusCode == 200) {
            emit(UpdatedDepartment(response.data.toString()));
          }
        } catch (e) {
          emit(UpdateDepartmentError(e.toString()));
        }
      }
    });
  }
}
