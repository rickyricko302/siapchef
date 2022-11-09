part of 'koleksi_cubit.dart';

abstract class KoleksiState extends Equatable {
  const KoleksiState();
}

class KoleksiInitial extends KoleksiState {
  @override
  List<Object> get props => [];
}

class KoleksiAda extends KoleksiState {
  List<DatabaseModel> data;
  KoleksiAda(this.data);
  @override
  List<Object> get props => [data];
}

class KoleksiKosong extends KoleksiState {
  @override
  List<Object> get props => [];
}
