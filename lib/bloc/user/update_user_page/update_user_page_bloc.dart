import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/services/repositories/nguoi_dung_repository.dart';

part 'update_user_page_event.dart';

part 'update_user_page_state.dart';

class UpdateUserPageBloc
    extends Bloc<UpdateUserPageEvent, UpdateUserPageState> {
  UpdateUserPageBloc() : super(UpdateUserPageInitial()) {
    on<UpdateUserPageEvent>((event, emit) async {
      NguoiDungRepository nguoiDungRepository = NguoiDungRepository();
      if (event is UpdateUserEvent) {
        emit(UpdatingUser());
        try {
          Response response = await nguoiDungRepository.updateUser(
              event.maND,
              event.userName,
              event.passWd,
              event.email,
              event.fullName,
              event.phone,
              event.maPB,
              event.status);

          if (response.statusCode == 200) {
            emit(UpdatedUser(response.data.toString()));
          }
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(UpdateUserError(e.response?.data));
          } else {
            emit(UpdateUserError(e.toString()));
          }
        }
      }

      if (event is UpdateUserWithImageEvent) {
        emit(UpdatingUser());
        try {
          Response response = await nguoiDungRepository.updateUserWithImage(
              event.maND,
              event.userName,
              event.passWd,
              event.email,
              event.fullName,
              event.phone,
              event.maPB,
              event.status,
              event.anh);

          if (response.statusCode == 200) {
            emit(UpdatedUser(response.data.toString()));
          }
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(UpdateUserError(e.response?.data));
          } else {
            emit(UpdateUserError(e.toString()));
          }
        }
      }
    });
  }
}
