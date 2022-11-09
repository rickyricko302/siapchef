import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siapchef/model/resep_list_model.dart';
import 'package:siapchef/repository/repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  Repository repository;
  SearchCubit(this.repository) : super(SearchInitial());
  late String key;
  void getSearchResep(query) async {
    try {
      emit(SearchLoading());
      var data = await repository.getSearchResep(query);
      key = query;
      emit(SearchSuccess(data));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
