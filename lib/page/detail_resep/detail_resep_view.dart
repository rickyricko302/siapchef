import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siapchef/configs/theme.dart';
import 'package:siapchef/model/database_model.dart';
import 'package:siapchef/page/detail_resep/detail_resep_cubit.dart';
import 'package:siapchef/page/koleksi/koleksi_cubit.dart';
import 'package:siapchef/repository/db_repository.dart';
import 'package:siapchef/repository/repository.dart';
import 'package:siapchef/widgets/deskripsi.dart';
import 'package:siapchef/widgets/resep.dart';

class DetailResepView extends StatefulWidget {
  DetailResepView(
      {Key? key,
      required this.title,
      required this.heroTag,
      required this.url,
      required this.imgthumb})
      : super(key: key);
  String heroTag, url, imgthumb, title;
  @override
  State<DetailResepView> createState() => _DetailResepViewState();
}

class _DetailResepViewState extends State<DetailResepView>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DetailResepStepCubit(),
          ),
          BlocProvider(
            create: (context) => DetailResepCubit(Repository()),
          ),
        ],
        child: Scaffold(
          backgroundColor: hitam,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Detail Resep"),
            centerTitle: true,
            actions: [
              BlocBuilder<DetailDbCubit, bool>(
                builder: (context, state) {
                  context.read<DetailDbCubit>().cekResep(widget.title);

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IconButton(
                        onPressed: () {
                          DatabaseModel data = DatabaseModel(
                              title: widget.title,
                              url: widget.url,
                              img: widget.imgthumb);
                          context.read<DetailDbCubit>().addResep(data);
                          if (state) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                                content: Text(
                                  "Berhasil Menghapus",
                                  style: TextStyle(color: Colors.white),
                                )));
                            context.read<KoleksiBadgeCubit>().setBadge(false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                                content: Text("Berhasil Menambah",
                                    style: TextStyle(color: Colors.white))));
                            context.read<KoleksiBadgeCubit>().setBadge(true);
                          }
                        },
                        icon: !state
                            ? Icon(Icons.favorite_outline)
                            : Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )),
                  );
                },
              )
            ],
          ),
          body: Column(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Hero(
                tag: widget.heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                      placeholder: AssetImage("assets/dummy.jpg"),
                      image: NetworkImage(widget.imgthumb)),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            BlocBuilder<DetailResepCubit, DetailResepState>(
              builder: (context, state) {
                if (state is DetailResepInitial) {
                  context.read<DetailResepCubit>().getDetail(widget.url);
                  return Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is DetailResepLoading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is DetailResepSuccess) {
                  return Expanded(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                            indicatorColor: orange,
                            controller: _tabController,
                            tabs: [Text("Deskripsi"), Text("Resep")]),
                      ),
                      Expanded(
                        child:
                            TabBarView(controller: _tabController, children: [
                          Deskripsi(
                            model: state.model,
                          ),
                          ResepView(
                            model: state.model,
                          )
                        ]),
                      )
                    ]),
                  );
                } else if (state is DetailResepError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.msg),
                    ),
                  );
                }
                return SizedBox();
              },
            )
          ]),
        ));
  }
}
