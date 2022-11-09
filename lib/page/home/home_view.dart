import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siapchef/Page/home/home_cubit.dart';
import 'package:siapchef/page/detail_resep/detail_resep_view.dart';
import 'package:siapchef/repository/repository.dart';
import '../../configs/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Widget();
  }
}

class _Widget extends StatelessWidget {
  const _Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<HomeKategoriCubit>().state is KategoriInitial) {
      context.read<HomeKategoriCubit>().getKategori();
    }
    if (context.read<HomeResepCubit>().state is HomeResepInitial) {
      context.read<HomeResepCubit>().getHomeResep("");
    }
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: hitam,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Datang,",
                              style: TextStyle(fontSize: 25, color: putih),
                            ),
                            Text(
                              "Sudah siap menjadi chef ala-ala?",
                              style: TextStyle(fontSize: 13, color: abu),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showAboutDialog(
                                context: context,
                                applicationName: "Siap Chef",
                                applicationVersion: "v1.0",
                                applicationLegalese:
                                    "Sesuai namanya aplikasi ini menyediakan resep-resep menu masakan. Terimakasih sudah menggunakan :)\n- Ricky V",
                                applicationIcon: Image(
                                  image: AssetImage("assets/chef.png"),
                                  width: 50,
                                  height: 50,
                                ));
                          },
                          child: CircleAvatar(
                            backgroundColor: orange,
                            radius: 25,
                            child: CircleAvatar(
                              backgroundColor: orange,
                              radius: 30,
                              backgroundImage: AssetImage("assets/chef.png"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(left: BorderSide(width: 2, color: orange))),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Kategori Resep",
                style: TextStyle(fontSize: 23, color: putih),
              ),
            ),
            Container(
              height: 40,
              child: BlocBuilder<HomeKategoriCubit, HomeState>(
                builder: (context, state) {
                  if (state is KategoriLoading) {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 20, right: 3),
                            width: 80,
                            height: 40,
                            child: Shimmer.fromColors(
                              baseColor: Colors.black,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                color: Colors.grey,
                              ),
                            ),
                          );
                        });
                  } else if (state is KategoriSuccess) {
                    return BlocBuilder<HomeKategoriIndex, int>(
                      builder: (context, stateIndex) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: state.model.results!.length + 1,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 40,
                                margin: EdgeInsets.only(left: 20, right: 3),
                                child: ElevatedButton(
                                    style: index == stateIndex
                                        ? ElevatedButton.styleFrom(
                                            primary: hitam,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(color: orange),
                                                borderRadius:
                                                    BorderRadius.circular(8)))
                                        : null,
                                    onPressed: () {
                                      context
                                          .read<HomeKategoriIndex>()
                                          .onButtonPress(index);
                                      String query = index == 0
                                          ? ""
                                          : state
                                              .model.results![index - 1]!.key!;
                                      context
                                          .read<HomeResepCubit>()
                                          .getHomeResep(query);
                                    },
                                    child: Text(
                                      index == 0
                                          ? "Semua Kategori"
                                          : state.model.results![index - 1]!
                                              .category!,
                                      style: TextStyle(
                                          color: index == stateIndex
                                              ? orange
                                              : null),
                                    )),
                              );
                            });
                      },
                    );
                  } else if (state is KategoriError) {
                    return Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            context.read<HomeKategoriCubit>().getKategori();
                          },
                          child: Text(
                            "Gagal memuat, coba lagi",
                            style: TextStyle(color: Colors.white),
                          )),
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: BlocBuilder<HomeResepCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeResepLoading) {
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: 6,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 200 / 270,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return Container(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            });
                      } else if (state is HomeResepSuccess) {
                        return Column(
                          children: [
                            GridView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: state.model.results!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 200 / 270,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10),
                                itemBuilder: (context, index) {
                                  return Material(
                                    color: Color.fromARGB(255, 33, 33, 33),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailResepView(
                                                      heroTag: "Hero " +
                                                          index.toString(),
                                                      url: state
                                                          .model
                                                          .results![index]!
                                                          .key!,
                                                      imgthumb: state
                                                          .model
                                                          .results![index]!
                                                          .thumb!,
                                                      title: state
                                                          .model
                                                          .results![index]!
                                                          .title!,
                                                    )));
                                      },
                                      child: Ink(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Hero(
                                              tag: "Hero " + index.toString(),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FadeInImage(
                                                  placeholder: AssetImage(
                                                      "assets/dummy.jpg"),
                                                  image: NetworkImage(state
                                                      .model
                                                      .results![index]!
                                                      .thumb!),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              state.model.results![index]!
                                                  .title!,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: state
                                                              .model
                                                              .results![index]!
                                                              .difficulty!
                                                              .contains("Mudah")
                                                          ? Colors.green
                                                          : Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    state.model.results![index]!
                                                        .difficulty!,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  String kategori =
                                      context.read<HomeResepCubit>().query;
                                  context
                                      .read<HomeResepCubit>()
                                      .getHomeResep(kategori);
                                },
                                child: Text("Ganti menu resep")),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      } else if (state is HomeResepError) {
                        return Container(
                          margin: EdgeInsets.only(top: 100),
                          child: Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  String kategori =
                                      context.read<HomeResepCubit>().query;
                                  context
                                      .read<HomeResepCubit>()
                                      .getHomeResep(kategori);
                                },
                                child: Text(
                                  "Gagal memuat, coba lagi",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
