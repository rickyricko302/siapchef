import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class MainCubit extends Cubit<int> {
  MainCubit() : super(0);
  void changePage(index) {
    emit(index);
  }
}
