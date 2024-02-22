import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/ui/user_dashboard/home_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0;

  // Define your pages here
  final List<Widget> _pages = [
    BlocProvider(
  create: (context) => ProfileBloc()..add(FetchProfileEvent()),
  child: HomeScreen(),
),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: SizeConfig.blockHeight * 11.6,
        width: SizeConfig.blockWidth * 100,
        decoration: const BoxDecoration(
          color: COLORS.white,
          boxShadow: [
            BoxShadow(
              color: COLORS.blackLight,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: COLORS.white,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icons/home.png",
                width: SizeConfig.blockWidth * 5,
                height: SizeConfig.blockHeight * 5,
                color: (_selectedIndex == 0) ? COLORS.lightBlack : COLORS.navTxt,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icons/membership.png",
                width: SizeConfig.blockWidth * 5,
                height: SizeConfig.blockHeight * 5,
                color: (_selectedIndex == 1) ? COLORS.lightBlack : COLORS.navTxt,
              ),
              label: "Membership",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icons/activities.png",
                width: SizeConfig.blockWidth * 5,
                height: SizeConfig.blockHeight * 5,
                color: (_selectedIndex == 2) ? COLORS.lightBlack : COLORS.navTxt,
              ),
              label: "Activities",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icons/explore.png",
                width: SizeConfig.blockWidth * 5,
                height: SizeConfig.blockHeight * 5,
                color: (_selectedIndex == 3) ? COLORS.lightBlack : COLORS.navTxt,
              ),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icons/profile.png",
                width: SizeConfig.blockWidth * 5,
                height: SizeConfig.blockHeight * 5,
                color: (_selectedIndex == 4) ? COLORS.lightBlack : COLORS.navTxt,
              ),
              label: "Profile",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: COLORS.lightBlack,
          unselectedItemColor: COLORS.navTxt,
          selectedLabelStyle: TextStyle(
            color: COLORS.lightBlack,
            fontFamily: "Lato",
            fontSize: SizeConfig.blockWidth * 3.2,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            color: COLORS.navTxt,
            fontFamily: "Lato",
            fontSize: SizeConfig.blockWidth * 3.2,
            fontWeight: FontWeight.w600,
          ),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}