import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siapchef/page/detail_resep/detail_resep_view.dart';
import 'package:siapchef/page/koleksi/koleksi_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../configs/theme.dart';

class KoleksiView extends StatelessWidget {
  const KoleksiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<KoleksiCubit>().getAllData();
    if (context.read<KoleksiBadgeCubit>().state) {
      context.read<KoleksiBadgeCubit>().setBadge(false);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(left: BorderSide(width: 2, color: orange))),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.only(left: 5),
          child: Text(
            "Koleksi Menu Resep Anda",
            style: TextStyle(fontSize: 23, color: putih),
          ),
        ),
        Expanded(
          child: BlocBuilder<KoleksiCubit, KoleksiState>(
            builder: (context, state) {
              if (state is KoleksiKosong) {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_outlined,
                      color: Colors.red,
                      size: 180,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Belum ada koleksi resep disini"),
                  ],
                ));
              } else if (state is KoleksiAda) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: OpenContainer(
                          transitionDuration: Duration(seconds: 1),
                          closedColor: hitam,
                          openColor: hitam,
                          openBuilder: (context, action) => DetailResepView(
                              title: state.data[index].title!,
                              heroTag: "",
                              url: state.data[index].url!,
                              imgthumb: state.data[index].img!),
                          closedBuilder: (context, action) => ListTile(
                            onTap: () {
                              action();
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(state.data[index].img!),
                            ),
                            trailing: Text(
                              (index + 1).toString(),
                              style: TextStyle(color: orange),
                            ),
                            title: Text(
                              state.data[index].title!,
                              style: TextStyle(fontSize: 14),
                            ),
                            tileColor: Color.fromARGB(255, 33, 33, 33),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: state.data.length);
              }
              return SizedBox();
            },
          ),
        )
      ],
    );
  }
}
