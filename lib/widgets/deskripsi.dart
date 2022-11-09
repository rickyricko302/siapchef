import 'package:flutter/material.dart';
import 'package:siapchef/configs/theme.dart';
import 'package:siapchef/model/detail_resep_model.dart';

class Deskripsi extends StatelessWidget {
  DetailResepModel model;
  Deskripsi({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.results!.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            Text(
              "Oleh ${model.results!.author!.user!}, ${model.results!.author!.datePublished!}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 33, 33, 33),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.timer_sharp,
                        color: orange,
                      ),
                      Text(model.results!.times!)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.people,
                        color: orange,
                      ),
                      Text(model.results!.servings!)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.signal_cellular_alt_sharp,
                        color: orange,
                      ),
                      Text(model.results!.difficulty!)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: abu)),
              padding: EdgeInsets.all(10),
              child: Text(
                model.results!.desc!,
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
