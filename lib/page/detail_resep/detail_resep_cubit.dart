import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siapchef/model/database_model.dart';
import 'package:siapchef/model/detail_resep_model.dart';
import 'package:siapchef/repository/db_repository.dart';
import 'package:siapchef/repository/repository.dart';

part 'detail_resep_state.dart';

class DetailResepCubit extends Cubit<DetailResepState> {
  Repository repository;
  DetailResepCubit(this.repository) : super(DetailResepInitial());

  void getDetail(key) async {
    try {
      emit(DetailResepLoading());
      var data = await repository.getDetailResep(key);
      emit(DetailResepSuccess(data));
    } catch (e) {
      emit(DetailResepError(e.toString()));
    }
  }
}

class DetailResepStepCubit extends Cubit<int> {
  DetailResepStepCubit() : super(0);

  void gantiStep(index) {
    emit(index);
  }
}

class DetailDbCubit extends Cubit<bool> {
  DbRepository dbRepository;
  DetailDbCubit(this.dbRepository) : super(false);

  void addResep(DatabaseModel data) async {
    var res = await dbRepository.insertResep(data);
    cekResep(data.title!);
  }

  void cekResep(String title) async {
    var res = await dbRepository.cekResep(title);
    emit(res);
  }

  Future<void> closeDb() async {
    await dbRepository.closeDb();
  }
}
