import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/layout/cubit/cubit.dart';
import 'package:travelapp/layout/cubit/states.dart';

class Navigationbar extends StatelessWidget {
  const Navigationbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            index: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            height: 60.0,
            color: Colors.white,
            buttonBackgroundColor: const Color(0xFf2a5885).withOpacity(0.2),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 150),
            items: const <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Colors.black,
              ),
              Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
              Icon(
                Icons.person_pin_circle_outlined,
                size: 30,
                color: Colors.black,
              ),
              Icon(
                Icons.notifications,
                size: 30,
                color: Colors.black,
              ),
              Icon(
                Icons.perm_identity,
                size: 30,
                color: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }
}
