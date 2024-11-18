import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/core/services/injection_container.dart';
import '/core/utils/color_schemes.g.dart';
import '/core/utils/router.dart';
import '/src/rental/presentation/cubit/detail_rental/detail_rental_cubit.dart';
import 'core/utils/constants.dart';
import 'core/utils/env.dart';
import 'core/utils/simple_bloc_observer.dart';
import 'src/authentication/presentation/bloc/authentication_bloc.dart';
import 'src/authentication/presentation/theme_shared_prefs/theme_shared_prefs_cubit.dart';
import 'src/equipment/presentation/blocs/category/category_bloc.dart';
import 'src/equipment/presentation/blocs/equipment/equipment_bloc.dart';
import 'src/equipment/presentation/cubits/equipment_shared_prefs/equipment_shared_prefs_cubit.dart';
import 'src/equipment/presentation/cubits/search_equipment/search_equipment_cubit.dart';
import 'src/home/presentation/cubit/home_cubit.dart';
import 'src/package/presentation/cubit/add_package/add_package_cubit.dart';
import 'src/package/presentation/cubit/detail_package/detail_package_cubit.dart';
import 'src/package/presentation/cubit/edit_package/edit_package_cubit.dart';
import 'src/package/presentation/cubit/packages/packages_cubit.dart';
import 'src/printer/presentation/cubit/bluetooth_status/bluetooth_status_cubit.dart';
import 'src/printer/presentation/printer/printer_bloc.dart';
import 'src/printer/presentation/cubit/printer_connection_status/printer_connection_status/printer_connection_status_cubit.dart';
import 'src/rental/presentation/cubit/add_rental/add_rental_cubit.dart';
import 'src/rental/presentation/cubit/rental_view/rental_view_cubit.dart';
import 'src/rental/presentation/cubit/rentals/rentals_cubit.dart';
import 'src/rental/presentation/cubit/search_rental/search_rental_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  Bloc.observer = SimpleBlocObserver();

  await init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(Constants.equipmentCategory);
  await prefs.remove(Constants.equipmentView);
  await prefs.remove(Constants.rentalView);
  int? themeMode = prefs.getInt(Constants.themeMode);
  if (themeMode == null) {
    await prefs.setInt(Constants.themeMode, 0);
  }
  await checkPermissions();

  runApp(const MainApp());
}

checkPermissions() async {
  var location = await Permission.location.status;

  if (location.isDenied) {
    await [
      Permission.location,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect
    ].request();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthenticationBloc>()),
        BlocProvider(
            create: (context) => sl<ThemeSharedPrefsCubit>()..loadThemeMode()),
        BlocProvider(create: (context) => sl<CategoryBloc>()),
        BlocProvider(create: (context) => sl<EquipmentSharedPrefsCubit>()),
        BlocProvider(create: (context) => sl<EquipmentBloc>()),
        BlocProvider(create: (context) => sl<SearchEquipmentCubit>()),
        BlocProvider(create: (context) => sl<HomeCubit>()),
        BlocProvider(create: (context) => sl<RentalsCubit>()),
        BlocProvider(create: (context) => sl<RentalViewCubit>()),
        BlocProvider(create: (context) => sl<DetailRentalCubit>()),
        BlocProvider(create: (context) => sl<AddRentalCubit>()),
        BlocProvider(create: (context) => sl<SearchRentalCubit>()),
        BlocProvider(create: (context) => sl<PrinterConnectionStatusCubit>()),
        BlocProvider(create: (context) => sl<PrinterBloc>()),
        BlocProvider(create: (context) => sl<BluetoothStatusCubit>()),
        BlocProvider(create: (context) => sl<AddPackageCubit>()),
        BlocProvider(create: (context) => sl<DetailPackageCubit>()),
        BlocProvider(create: (context) => sl<PackagesCubit>()),
        BlocProvider(create: (context) => sl<EditPackageCubit>()),
      ],
      child: BlocBuilder<ThemeSharedPrefsCubit, ThemeSharedPrefsState>(
        builder: (context, state) {
          ThemeMode? themeMode;

          switch (state.themeMode) {
            case 0:
              themeMode = ThemeMode.system;
              break;
            case 1:
              themeMode = ThemeMode.light;
              break;
            case 2:
              themeMode = ThemeMode.dark;
              break;
            default:
          }

          return MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('id')],
            locale: const Locale('id'),
            title: 'AA Outdoor Cashier',
            themeMode: themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              fontFamily: 'Poppins',
              iconTheme: IconThemeData(
                color: lightColorScheme.primary,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
              fontFamily: 'Poppins',
              iconTheme: IconThemeData(
                color: darkColorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
