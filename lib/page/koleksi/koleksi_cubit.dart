import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siapchef/model/database_model.dart';
import 'package:siapchef/repository/db_repository.dart';

part 'koleksi_state.dart';

class KoleksiCubit extends Cubit<KoleksiState> {
  DbRepository dbRepository;
  KoleksiCubit({required this.dbRepository}) : super(KoleksiInitial());

  void getAllData() async {
    List<Map<String, dynamic>> data = await dbRepository.getAllData();
    List<DatabaseModel> dataList = [];
    data.forEach((element) {
      dataList.add(DatabaseModel.fromJson(element));
    });
    if (dataList.length == 0) {
      emit(KoleksiKosong());
    } else {
      emit(KoleksiAda(dataList));
    }
  }
}

class KoleksiBadgeCubit extends Cubit<bool> {
  KoleksiBadgeCubit() : super(false);
  void setBadge(status) {
    emit(status);
    print(status);
  }
}
