import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../rental/presentation/cubit/add_rental/add_rental_cubit.dart';
import '/core/utils/router.dart';
import '/src/authentication/presentation/widget/add_equipment_modal_bottom_sheet.dart';
import '/src/authentication/presentation/widget/nav_bar.dart';
import '/src/authentication/presentation/widget/nav_model.dart';
import '/src/equipment/presentation/view/equipment_screen.dart';
import '/src/home/presentation/view/home_screen.dart';
import '/src/report/presentation/view/report_screen.dart';
import '/src/setting/presentation/view/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final equipmentsNavKey = GlobalKey<NavigatorState>();
  final reportNavKey = GlobalKey<NavigatorState>();
  final settingNavKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
        page: const HomeScreen(),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const EquipmentScreen(),
        navKey: equipmentsNavKey,
      ),
      NavModel(
        page: const ReportScreen(),
        navKey: reportNavKey,
      ),
      NavModel(
        page: const SettingScreen(),
        navKey: settingNavKey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: items
            .map((page) => Navigator(
                  key: page.navKey,
                  onGenerateInitialRoutes: (navigator, initialRoute) {
                    return [MaterialPageRoute(builder: (context) => page.page)];
                  },
                ))
            .toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          if (_selectedIndex == 1) {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddEquipmentModalBottomSheet();
              },
            );
          } else {
            context.read<AddRentalCubit>().clearAddRental();
            router.pushNamed('add_rental');
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavBar(
        pageIndex: _selectedIndex,
        onTap: (index) {
          if (index == _selectedIndex) {
            items[index]
                .navKey
                .currentState
                ?.popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
