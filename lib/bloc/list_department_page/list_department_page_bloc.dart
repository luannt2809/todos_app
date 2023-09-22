import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/services/repositories/phong_ban_repository.dart';

part 'list_department_page_event.dart';

part 'list_department_page_state.dart';

class ListDepartmentPageBloc
    extends Bloc<ListDepartmentPageEvent, ListDepartmentPageState> {
  List<PhongBan> listDepartment = [];

  ListDepartmentPageBloc() : super(ListDepartmentPageInitial()) {
    on<ListDepartmentPageEvent>((event, emit) async {
      PhongBanRepository phongBanRepository = PhongBanRepository();
      // TODO: implement event handler
      if (event is GetListDepartment) {
        try {
          emit(ListDepartmentPageLoading());
          listDepartment = await phongBanRepository.getListDepartment();
          if (listDepartment.isNotEmpty) {
            emit(ListDepartmentPageLoaded(listDepartment: listDepartment));
          } else {
            emit(GetListDepartmentEmpty());
          }
        } catch (e) {
          emit(ListDepartmentPageError(error: "Error $e"));
        }
      }
    });
  }
}
