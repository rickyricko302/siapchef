import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siapchef/model/kategori_model.dart';
import 'package:siapchef/model/resep_list_model.dart';
import 'package:siapchef/repository/repository.dart';
import 'package:flutter/material.dart';
part 'home_state.dart';

class HomeKategoriIndex extends Cubit<int> {
  HomeKategoriIndex() : super(0);

  void onButtonPress(index) {
    emit(index);
  }
}

class HomeKategoriCubit extends Cubit<HomeState> {
  Repository repository;
  HomeKategoriCubit(this.repository) : super(KategoriInitial());

  void getKategori() async {
    try {
      emit(KategoriLoading());
      var data = await repository.getKategori();
      emit(KategoriSuccess(data));
    } catch (e) {
      emit(KategoriError(e.toString()));
    }
  }
}

class HomeResepCubit extends Cubit<HomeState> {
  Repository repository;
  HomeResepCubit(this.repository) : super(HomeResepInitial());
  String query = "";
  void getHomeResep(query) async {
    this.query = query;
    try {
      emit(HomeResepLoading());
      var data = await repository.getHomeResep(query);
      emit(HomeResepSuccess(data));
    } catch (e) {
      print(e);
      emit(HomeResepError(e.toString()));
    }
  }
}
