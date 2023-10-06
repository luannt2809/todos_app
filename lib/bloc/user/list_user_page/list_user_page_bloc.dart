
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/models/nguoi_dung.dart';

import 'package:todos_app/services/repositories/nguoi_dung_repository.dart';

part 'list_user_page_event.dart';

part 'list_user_page_state.dart';

class ListUserPageBloc extends Bloc<ListUserPageEvent, ListUserPageState> {
  List<NguoiDung> listUser = [];

  ListUserPageBloc() : super(ListUserPageInitial()) {
    on<ListUserPageEvent>((event, emit) async {
      NguoiDungRepository nguoiDungRepository = NguoiDungRepository();
      // TODO: implement event handler
      if (event is GetListUser) {
        emit(ListUserPageLoading());
        try {
          listUser = await nguoiDungRepository.getListUser();
          if (listUser.isNotEmpty) {
            emit(ListUserPageLoaded(listUser: listUser));
          } else {
            emit(GetListUserEmpty());
          }
        } on DioException catch (e) {
          if(e.type == DioExceptionType.badResponse){
            emit(ListUserPageError(error: "Error: ${e.response?.data}"));
          } else {
            emit(ListUserPageError(error: "Error: $e"));
          }
        }
      }
    });
  }
}
