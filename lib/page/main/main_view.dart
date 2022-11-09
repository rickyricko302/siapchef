import 'package:flutter/material.dart';
import 'package:siapchef/Page/home/home_cubit.dart';
import 'package:siapchef/Page/home/home_view.dart';
import 'package:siapchef/Page/main/main_cubit.dart';
import 'package:siapchef/page/detail_resep/detail_resep_cubit.dart';
import 'package:siapchef/page/koleksi/koleksi_cubit.dart';
import 'package:siapchef/page/koleksi/koleksi_view.dart';
import 'package:siapchef/page/search/search_cubit.dart';
import 'package:siapchef/page/search/search_view.dart';
import 'package:siapchef/repository/db_repository.dart';
import '../../repository/repository.dart';
import '../main/../../configs/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeKategoriIndex(),
        ),
        BlocProvider(
          create: (context) => HomeKategoriCubit(Repository()),
        ),
        BlocProvider(
          create: (context) => HomeResepCubit(Repository()),
        ),
        BlocProvider(
          create: (context) => MainCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(Repository()),
        ),
        BlocProvider(
          create: (context) => KoleksiCubit(dbRepository: DbRepository()),
        ),
      ],
      child: _Widget(),
    );
  }
}

class _Widget extends StatelessWidget {
  const _Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return BlocBuilder<MainCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: hitam,
          body: SafeArea(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                context.read<MainCubit>().changePage(index);
              },
              children: [HomePage(), SearchView(), KoleksiView()],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: (index) {
                context.read<MainCubit>().changePage(index);
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linearToEaseOut);
              },
              selectedItemColor: orange,
              unselectedItemColor: abu,
              backgroundColor: abugelap,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        Icon(Icons.collections_bookmark),
                        BlocBuilder<KoleksiBadgeCubit, bool>(
                          builder: (context, isBadgeShow) {
                            return Visibility(
                              visible: isBadgeShow,
                              child: Positioned(
                                  right: 0,
                                  child: Icon(
                                    Icons.brightness_1,
                                    color: Colors.red,
                                    size: 12,
                                  )),
                            );
                          },
                        )
                      ],
                    ),
                    label: "Koleksi")
              ]),
        );
      },
    );
  }
}
