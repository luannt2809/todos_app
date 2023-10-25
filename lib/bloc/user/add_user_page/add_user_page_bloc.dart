import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/services/repositories/nguoi_dung_repository.dart';

part 'add_user_page_event.dart';

part 'add_user_page_state.dart';

class AddUserPageBloc extends Bloc<AddUserPageEvent, AddUserPageState> {
  AddUserPageBloc() : super(AddUserPageInitial()) {
    on<AddUserPageEvent>((event, emit) async {
      // TODO: implement event handler
      NguoiDungRepository nguoiDungRepository = NguoiDungRepository();
      if (event is AddUserEvent) {
        emit(AddUserLoading());
        try {
          Response response = await nguoiDungRepository.insertUser(
              event.userName,
              event.passWd,
              event.email,
              event.fullName,
              event.phone,
              event.maPB,
              event.status);
          if (response.statusCode == 200) {
            emit(AddUserLoaded(msg: response.data.toString()));
          }
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(AddUserError(error: "Error: ${e.response?.data}"));
          } else {
            emit(AddUserError(error: e.toString()));
          }
        }
      }

      if (event is AddUserWithImageEvent) {
        emit(AddUserLoading());
        try {
          Response response = await nguoiDungRepository.insertUserWithImage(
              event.userName,
              event.passWd,
              event.email,
              event.fullName,
              event.phone,
              event.maPB,
              event.status,
              event.anh);
          if (response.statusCode == 200) {
            emit(AddUserLoaded(msg: response.data.toString()));
          }
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(AddUserError(error: "Error: ${e.response?.data}"));
          } else {
            emit(AddUserError(error: e.toString()));
          }
        }
      }
    });
  }
}
