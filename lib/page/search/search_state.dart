part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchSuccess extends SearchState {
  ResepListModel model;
  SearchSuccess(this.model);
  @override
  List<Object> get props => [model];
}

class SearchError extends SearchState {
  String msg;
  SearchError(this.msg);
  @override
  List<Object> get props => [msg];
}
