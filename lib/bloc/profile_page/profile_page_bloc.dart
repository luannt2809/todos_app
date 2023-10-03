import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/models/nguoi_dung.dart';

import 'package:todos_app/services/repositories/nguoi_dung_repository.dart';

part 'profile_page_event.dart';

part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  List<NguoiDung> userList = [];

  ProfilePageBloc() : super(ProfilePageInitial()) {
    on<ProfilePageEvent>((event, emit) async {
      NguoiDungRepository nguoiDungRepository = NguoiDungRepository();
      if (event is GetInfoEvent) {
        try {
          emit(GetInfoLoading());
          userList = await nguoiDungRepository.getInfoUser();
          emit(GetInfoLoaded(userList: userList));
        } catch (e) {
          emit(GetInfoError(e.toString()));
        }
      }

      if (event is ChangeInfoEvent) {
        try {
          emit(ChangingInfo());
          Response response = await nguoiDungRepository.updateInfo(
              event.userName, event.email, event.fullName, event.phone);
          if (response.statusCode == 200) {
            emit(ChangeInfoSuccess(response.data.toString()));
          }
        } catch (e) {
          emit(ChangeInfoError(error: "Error: $e"));
        }
      }
    });
  }
}
