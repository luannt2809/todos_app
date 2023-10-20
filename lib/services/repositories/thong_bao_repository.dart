import 'package:todos_app/models/thong_bao.dart';
import 'package:todos_app/services/providers/thong_bao_provider.dart';

class ThongBaoRepository {
  ThongBaoProvider thongBaoProvider = ThongBaoProvider();
  Future<List<ThongBao>> getListThongBao() async {
    return thongBaoProvider.getListThongBao();
  }
}