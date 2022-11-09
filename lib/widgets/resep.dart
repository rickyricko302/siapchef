import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siapchef/model/detail_resep_model.dart';
import 'package:siapchef/page/detail_resep/detail_resep_cubit.dart';

class ResepView extends StatelessWidget {
  DetailResepModel model;
  ResepView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, bottom: 20),
              child: Text(
                "Bahan-bahan yang diperlukan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
                children: List<Widget>.generate(
              model.results!.ingredient!.length,
              (index) => Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 33, 33, 33),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(model.results!.ingredient![index]),
              ),
            )),
            Container(
              margin: EdgeInsets.only(left: 5, bottom: 20, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Langkah-langkah membuat",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Petunjuk penggunaan"),
                              content: Text(
                                  "Anda dapat menekan nomor langkah (1,2,3,4...) untuk menandai bahwa anda sudah sampai dilangkah itu"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Okee"))
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.help_outline_sharp),
                    iconSize: 20,
                  )
                ],
              ),
            ),
            BlocBuilder<DetailResepStepCubit, int>(
              builder: (context, state) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: model.results!.step!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<DetailResepStepCubit>()
                                .gantiStep(index);
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 33, 33, 33),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: index == state
                                      ? Colors.red
                                      : Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 33, 33, 33),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              model.results!.step![index].substring(2),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
