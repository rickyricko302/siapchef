import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siapchef/page/splashscreen/splash_view.dart';
import 'package:siapchef/repository/repository.dart';
import 'Page/main/main_view.dart';
import 'configs/theme.dart';
import 'page/detail_resep/detail_resep_cubit.dart';
import 'page/koleksi/koleksi_cubit.dart';
import 'repository/db_repository.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const SiapChef());
}

class SiapChef extends StatelessWidget {
  const SiapChef({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DetailDbCubit(DbRepository()),
          ),
          BlocProvider(
            create: (context) => KoleksiBadgeCubit(),
          )
        ],
        child: MaterialApp(
            theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.deepOrange,
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorSchemeSeed: Colors.deepOrange),
            themeMode: ThemeMode.dark,
            home: SplashScreen()),
      ),
    );
  }
}
