import 'package:wathakren/pages/main_screen.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavBar extends StatelessWidget {
  final GlobalKey<State<BottomNavigationBar>> botNavBarKey;
  final GlobalKey<State<MainScreen>> mainKey;

  const CustomNavBar({
    required this.botNavBarKey,
    required this.mainKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainScreenState mainScreenState = mainKey.currentState as MainScreenState;

    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Provider.of<ThemeProvider>(context).kPrimary,
      ),
      child: Stack(
        children: [
          BottomNavigationBar(
            key: botNavBarKey,
            items: [
              BottomNavigationBarItem(icon: SizedBox(), label: ""),
              BottomNavigationBarItem(icon: SizedBox(), label: ""),
              BottomNavigationBarItem(icon: SizedBox(), label: ""),
              BottomNavigationBarItem(icon: SizedBox(), label: ""),
            ],
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: IconThemeData(color: Colors.white),
            unselectedIconTheme:
                IconThemeData(color: Colors.white.withOpacity(.5)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            onTap: (x) {
              mainScreenState.reAnimate(x);
            },
          ),
          Center(
            child: Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    (botNavBarKey.currentWidget! as BottomNavigationBar)
                        .onTap!(0);
                  },
                  child: Image.asset(
                    mainScreenState.selectedIndex() == 0
                        ? "assets/icons/home_selected.png"
                        : "assets/icons/home_uns.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                Spacer(flex: 2),
                GestureDetector(
                  onTap: () {
                    (botNavBarKey.currentWidget! as BottomNavigationBar)
                        .onTap!(1);
                  },
                  child: Image.asset(
                    mainScreenState.selectedIndex() == 1
                        ? "assets/icons/edit_selected.png"
                        : "assets/icons/edit_uns.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                Spacer(flex: 2),
                GestureDetector(
                  onTap: () {
                    (botNavBarKey.currentWidget! as BottomNavigationBar)
                        .onTap!(2);
                  },
                  child: Image.asset(
                    mainScreenState.selectedIndex() == 2
                        ? "assets/icons/share_selected.png"
                        : "assets/icons/share_uns.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                Spacer(flex: 2),
                GestureDetector(
                  onTap: () {
                    (botNavBarKey.currentWidget! as BottomNavigationBar)
                        .onTap!(3);
                  },
                  child: Image.asset(
                    mainScreenState.selectedIndex() == 3
                        ? "assets/icons/bookmark_selected.png"
                        : "assets/icons/bookmark_uns.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
