
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/services/repositories/phong_ban_repository.dart';

part 'add_department_event.dart';
part 'add_department_state.dart';

class AddDepartmentBloc extends Bloc<AddDepartmentEvent, AddDepartmentState> {
  AddDepartmentBloc() : super(AddDepartmentInitial()) {
    on<AddDepartmentEvent>((event, emit) async {
      PhongBanRepository phongBanRepository = PhongBanRepository();
      if (event is AddDepartment) {
        emit(AddDepartmentLoading());
        try {
          Response response =
              await phongBanRepository.addDepartment(event.tenPB, event.arrMaVT);
          if (response.statusCode == 200) {
            emit(AddDepartmentLoaded(response.data.toString()));
          }
        } on DioException catch (e) {
          if(e.type == DioExceptionType.badResponse){
            emit(AddDepartmentError(e.response?.data));
          } else {
            emit(AddDepartmentError(e.toString()));
          }
        }
      }
    });
  }
}
