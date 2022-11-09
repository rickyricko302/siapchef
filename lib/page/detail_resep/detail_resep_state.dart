part of 'detail_resep_cubit.dart';

abstract class DetailResepState extends Equatable {
  const DetailResepState();
}

class DetailResepInitial extends DetailResepState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DetailResepLoading extends DetailResepState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DetailResepSuccess extends DetailResepState {
  DetailResepModel model;
  DetailResepSuccess(this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [model];
}

class DetailResepError extends DetailResepState {
  String msg;
  DetailResepError(this.msg);
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}
