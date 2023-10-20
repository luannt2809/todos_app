
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/models/thong_bao.dart';
import 'package:todos_app/services/repositories/thong_bao_repository.dart';

part 'notify_page_event.dart';
part 'notify_page_state.dart';

class NotifyPageBloc extends Bloc<NotifyPageEvent, NotifyPageState> {
  List<ThongBao> notifyList = [];

  NotifyPageBloc() : super(NotifyPageInitial()) {
    on<NotifyPageEvent>((event, emit) async {
      ThongBaoRepository thongBaoRepository = ThongBaoRepository();
      if(event is GetListNotifyEvent){
        try {
          emit(NotifyPageLoading());
          notifyList = await thongBaoRepository.getListThongBao();
          if(notifyList.isNotEmpty){
            emit(NotifyPageLoaded(notifyList: notifyList));
          } else {
            emit(GetListNotifyEmpty());
          }
        } on DioException catch (e){
          if(e.type == DioExceptionType.badResponse){
            emit(NotifyPageError(error: "Error: ${e.response?.data}"));
          } else {
            emit(NotifyPageError(error: e.toString()));
          }
        }
      }
    });
  }
}
