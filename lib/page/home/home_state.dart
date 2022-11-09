part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//Kategori State
class KategoriInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class KategoriLoading extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class KategoriSuccess extends HomeState {
  KategoriModel model;
  KategoriSuccess(this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class KategoriError extends HomeState {
  String msg;
  KategoriError(this.msg);
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}

//Home resep state
class HomeResepInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeResepLoading extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeResepSuccess extends HomeState {
  ResepListModel model;
  HomeResepSuccess(this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [this.model];
}

class HomeResepError extends HomeState {
  String msg;
  HomeResepError(this.msg);
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}
