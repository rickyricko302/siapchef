import 'package:flutter/material.dart';
import 'package:siapchef/configs/theme.dart';
import 'package:siapchef/page/main/main_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opaciti = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opaciti = 1;
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: AnimatedOpacity(
              opacity: opaciti,
              duration: Duration(seconds: 1),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/chef.png"),
                backgroundColor: orange,
                radius: 60,
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Siap Chef",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 120, child: Divider()),
              Text(
                "By Ricky V | _Hikki",
                style: TextStyle(color: abu),
              )
            ],
          ),
        )
      ],
    ));
  }
}
