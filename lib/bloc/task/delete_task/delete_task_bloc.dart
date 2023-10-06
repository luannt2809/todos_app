import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/services/repositories/cong_viec_respository.dart';

part 'delete_task_event.dart';

part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  DeleteTaskBloc() : super(DeleteTaskInitial()) {
    on<DeleteTaskEvent>((event, emit) async {
      CongViecRepository congViecRepository = CongViecRepository();
      if (event is DeleteTask) {
        emit(DeletingTask());
        try {
          Response response = await congViecRepository.deleteTask(event.maCV);
          if (response.statusCode == 200) {
            emit(DeletedTask(response.data.toString()));
          }
        } on DioException catch (e) {
          if(e.type == DioExceptionType.badResponse){
            emit(DeleteTaskError('Error: ${e.response?.data}'));
          } else {
            emit(DeleteTaskError(e.toString()));
          }
        }
      }
    });
  }
}
