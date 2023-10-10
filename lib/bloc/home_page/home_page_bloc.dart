import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/repositories/cong_viec_respository.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  List<CongViec> taskList = [];

  HomePageBloc() : super(HomePageInitial()) {
    on<GetTaskList>((event, emit) async {
      CongViecRepository congViecRepository = CongViecRepository();
      try {
        emit(HomePageLoading());
        taskList = await congViecRepository.getAllCongViecByMaND(
            event.startDate.toString());
        if (taskList.isNotEmpty) {
          emit(HomePageLoaded(taskList: taskList));
        } else {
          emit(GetListTaskEmpty());
        }
        // if (taskList[0].error != null) {
        //   emit(HomePageError(taskList[0].error));
        // }
      } on NetworkError {
        emit(const HomePageError("Failed to get data"));
      }
    });
  }
}
