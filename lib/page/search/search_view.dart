import 'package:flutter/material.dart';
import 'package:siapchef/configs/theme.dart';
import 'package:siapchef/page/search/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../detail_resep/detail_resep_view.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(left: BorderSide(width: 2, color: orange))),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.only(left: 5),
          child: Text(
            "Cari Menu Andalanmu",
            style: TextStyle(fontSize: 23, color: putih),
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (query) {
                context.read<SearchCubit>().getSearchResep(query);
              },
              decoration: InputDecoration(
                  hintText: "Masukan kata kunci",
                  filled: true,
                  fillColor: abugelap,
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            )),
        Expanded(child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fastfood,
                      color: orange,
                      size: 180,
                    ),
                    Text("Menu kamu akan kami carikan resepnya")
                  ],
                ),
              );
            } else if (state is SearchLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchSuccess) {
              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: GridView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 20),
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
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                          "Menampilkan hasil pencarian '${context.read<SearchCubit>().key}'"),
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ))
      ],
    );
  }
}
