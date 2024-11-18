import 'package:aa_outdoor/src/report/presentation/view/more_report_screen.dart';
import 'package:go_router/go_router.dart';

import '../../src/equipment/presentation/view/category_screen.dart';
import '../../src/package/presentation/view/add_package_screen.dart';
import '../../src/package/presentation/view/choose_equipment_package_screen.dart';
import '../../src/package/presentation/view/edit_choose_equipment_package_screen.dart';
import '../../src/package/presentation/view/edit_package_screen.dart';
import '../../src/package/presentation/view/package_screen.dart';
import '../../src/printer/presentation/view/printer_setting_screen.dart';
import '../../src/setting/presentation/view/theme_setting_screen.dart';
import '/src/authentication/presentation/views.dart';
import '/src/home/presentation/view/search_screen.dart';
import '/src/rental/presentation/views.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: 'splash',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
      path: '/main',
      name: 'main',
      builder: (context, state) => const MainScreen(),
      routes: [
        GoRoute(
          path: 'transaction_success',
          name: 'transaction_success',
          builder: (context, state) => const TransactionSuccessfulScreen(),
        ),
      ]),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/search',
    name: 'search',
    builder: (context, state) => const SearchScreen(),
  ),
  GoRoute(
    path: '/category',
    name: 'category',
    builder: (context, state) => const CategoryScreen(),
  ),
  GoRoute(
    path: '/rental',
    name: 'rental',
    builder: (context, state) => const RentalScreen(),
  ),
  GoRoute(
    path: '/add_rental',
    name: 'add_rental',
    builder: (context, state) => const ChooseEquipmentScreen(),
    routes: [
      GoRoute(
        path: 'confirm_equipment',
        name: 'confirm_equipment',
        builder: (context, state) => const ConfirmationEquipmentScreen(),
      ),
      GoRoute(
        path: 'detail_consumer',
        name: 'detail_consumer',
        builder: (context, state) => const DetailCustomerRentalScreen(),
      ),
      GoRoute(
        path: 'payment_rental',
        name: 'payment_rental',
        builder: (context, state) => const PaymentRentalScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/detail_rental',
    name: 'detail_rental',
    builder: (context, state) => const DetailRentalScreen(),
    routes: [
      GoRoute(
        path: 'preview_detail_rental',
        name: 'preview_detail_rental',
        builder: (context, state) => const PreviewDetailRentalScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/printer_setting',
    name: 'printer_setting',
    builder: (context, state) => const PrinterSettingScreen(),
  ),
  GoRoute(
    path: '/package',
    name: 'package',
    builder: (context, state) => const PackageScreen(),
    routes: [
      GoRoute(
        path: 'add_package',
        name: 'add_package',
        builder: (context, state) => const AddPackageScreen(),
      ),
      GoRoute(
        path: 'choose_equipment_package',
        name: 'choose_equipment_package',
        builder: (context, state) => const ChooseEquipmentPackageScreen(),
      ),
      GoRoute(
        path: 'edit_package',
        name: 'edit_package',
        builder: (context, state) => const EditPackageScreen(),
      ),
      GoRoute(
        path: 'edit_choose_equipment_package',
        name: 'edit_choose_equipment_package',
        builder: (context, state) {
          return const EditChooseEquipmentPackageScreen();
        },
      ),
    ],
  ),
  GoRoute(
    path: '/theme_setting',
    name: 'theme_setting',
    builder: (context, state) => const ThemeSettingScreen(),
  ),
  GoRoute(
    path: '/more_report',
    name: 'more_report',
    builder: (context, state) => const MoreReportScreen(),
  ),
]);
