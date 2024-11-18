import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../src/authentication/data/datasources.dart';
import '../../src/authentication/data/repositories.dart';
import '../../src/authentication/domain/repository/authentication_repository.dart';
import '../../src/authentication/domain/usecases.dart';
import '../../src/authentication/domain/usecases/get_theme_mode.dart';
import '../../src/authentication/domain/usecases/save_theme_mode.dart';
import '../../src/authentication/presentation/bloc/authentication_bloc.dart';
import '../../src/authentication/presentation/theme_shared_prefs/theme_shared_prefs_cubit.dart';
import '../../src/equipment/data/datasources.dart';
import '../../src/equipment/data/repositories.dart';
import '../../src/equipment/domain/repositories.dart';
import '../../src/equipment/domain/usecases.dart';
import '../../src/equipment/domain/usecases/search_equipment.dart';
import '../../src/equipment/presentation/blocs/category/category_bloc.dart';
import '../../src/equipment/presentation/blocs/equipment/equipment_bloc.dart';
import '../../src/equipment/presentation/cubits/equipment_shared_prefs/equipment_shared_prefs_cubit.dart';
import '../../src/equipment/presentation/cubits/search_equipment/search_equipment_cubit.dart';
import '../../src/home/presentation/cubit/home_cubit.dart';
import '../../src/package/data/datasources/package_remote_data_source.dart';
import '../../src/package/data/repositories/package_repository_implementation.dart';
import '../../src/package/domain/repositories/package_repository.dart';
import '../../src/package/domain/usecases.dart';
import '../../src/package/presentation/cubit/add_package/add_package_cubit.dart';
import '../../src/package/presentation/cubit/detail_package/detail_package_cubit.dart';
import '../../src/package/presentation/cubit/edit_package/edit_package_cubit.dart';
import '../../src/package/presentation/cubit/packages/packages_cubit.dart';
import '../../src/printer/data/datasources/printer_remote_data_source.dart';
import '../../src/printer/data/respositories/printer_repository_implementation.dart';
import '../../src/printer/domain/repositories/printer_repository.dart';
import '../../src/printer/domain/usecases.dart';
import '../../src/printer/domain/usecases/get_bluetooth_mac_address.dart';
import '../../src/printer/domain/usecases/print_bill.dart';
import '../../src/printer/domain/usecases/print_list_equipment.dart';
import '../../src/printer/domain/usecases/save_bluetooth_mac_address.dart';
import '../../src/printer/presentation/cubit/bluetooth_status/bluetooth_status_cubit.dart';
import '../../src/printer/presentation/cubit/printer_connection_status/printer_connection_status/printer_connection_status_cubit.dart';
import '../../src/printer/presentation/printer/printer_bloc.dart';
import '../../src/rental/data/datasources/rental_remote_data_source.dart';
import '../../src/rental/data/datasources/rental_shared_prefs_remote_data_source.dart';
import '../../src/rental/data/repositories/rental_repository_implementation.dart';
import '../../src/rental/data/repositories/rental_shared_prefs_repository_implementation.dart';
import '../../src/rental/domain/repositories/rental_repository.dart';
import '../../src/rental/domain/repositories/rental_shared_prefs_repository.dart';
import '../../src/rental/domain/usecases.dart';
import '../../src/rental/presentation/cubit/add_rental/add_rental_cubit.dart';
import '../../src/rental/presentation/cubit/detail_rental/detail_rental_cubit.dart';
import '../../src/rental/presentation/cubit/rental_view/rental_view_cubit.dart';
import '../../src/rental/presentation/cubit/rentals/rentals_cubit.dart';
import '../../src/rental/presentation/cubit/search_rental/search_rental_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => AuthenticationBloc(
          signIn: sl(),
          signOut: sl(),
          authState: sl(),
          getBluetoothMacAddress: sl(),
        ))
    ..registerFactory(
        () => ThemeSharedPrefsCubit(getThemeMode: sl(), saveThemeMode: sl()))
    ..registerFactory(() => CategoryBloc(
          addCategory: sl(),
          deleteCategory: sl(),
          getListCategory: sl(),
          updateCategory: sl(),
        ))
    ..registerFactory(() => EquipmentSharedPrefsCubit(
          getEquipmentCategory: sl(),
          saveEquipmentCategory: sl(),
          getEquipmentView: sl(),
          saveEquipmentView: sl(),
        ))
    ..registerFactory(() => EquipmentBloc(
          addEquipment: sl(),
          deleteEquipment: sl(),
          getListEquipmentByCategory: sl(),
          getListEquipment: sl(),
          updateEquipment: sl(),
        ))
    ..registerFactory(() => SearchEquipmentCubit(searchEquipment: sl()))
    ..registerFactory(() => HomeCubit(
          getListRentalByStatus: sl(),
        ))
    ..registerFactory(() => RentalsCubit(
          getListRentalByStatus: sl(),
          returnRental: sl(),
        ))
    ..registerFactory(() => RentalViewCubit(
          getRentalView: sl(),
          saveRentalView: sl(),
        ))
    ..registerFactory(() => DetailRentalCubit(getDetailRental: sl()))
    ..registerFactory(() => AddRentalCubit(addRental: sl()))
    ..registerFactory(() => SearchRentalCubit(searchRental: sl()))
    ..registerFactory(() => PrinterConnectionStatusCubit(
        connectToPrinter: sl(), saveBluetoothMacAddress: sl()))
    ..registerFactory(() => BluetoothStatusCubit())
    ..registerFactory(() => PrinterBloc(
          getBondedDevices: sl(),
          isBluetoothEnabled: sl(),
          openBluetoothSetting: sl(),
          printBill: sl(),
          printListEquipment: sl(),
        ))
    ..registerFactory(() => AddPackageCubit(addPackage: sl()))
    ..registerFactory(
        () => EditPackageCubit(updatePackage: sl(), getListEquipment: sl()))
    ..registerFactory(
        () => DetailPackageCubit(deletePackage: sl(), getDetailPackage: sl()))
    ..registerFactory(
        () => PackagesCubit(getListPackage: sl(), deletePackage: sl()))

    // Usecases

    /* Authentication */
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => AuthState(sl()))
    ..registerLazySingleton(() => GetThemeMode(sl()))
    ..registerLazySingleton(() => SaveThemeMode(sl()))

    /* Equipment */
    ..registerLazySingleton(() => AddCategory(sl()))
    ..registerLazySingleton(() => DeleteCategory(sl()))
    ..registerLazySingleton(() => GetListCategory(sl()))
    ..registerLazySingleton(() => UpdateCategory(sl()))
    ..registerLazySingleton(() => GetEquipmentCategory(sl()))
    ..registerLazySingleton(() => GetEquipmentView(sl()))
    ..registerLazySingleton(() => SaveEquipmentCategory(sl()))
    ..registerLazySingleton(() => SaveEquipmentView(sl()))
    ..registerLazySingleton(() => AddEquipment(sl()))
    ..registerLazySingleton(() => DeleteEquipment(sl()))
    ..registerLazySingleton(() => GetListEquipmentByCategory(sl()))
    ..registerLazySingleton(() => GetListEquipment(sl()))
    ..registerLazySingleton(() => UpdateEquipment(sl()))
    ..registerLazySingleton(() => SearchEquipment(sl()))

    /* Rental */
    ..registerLazySingleton(() => AddRental(sl()))
    ..registerLazySingleton(() => DeleteRental(sl()))
    ..registerLazySingleton(() => GetDetailRental(sl()))
    ..registerLazySingleton(() => GetListRentalByStatus(sl()))
    ..registerLazySingleton(() => GetListRental(sl()))
    ..registerLazySingleton(() => ReturnRental(sl()))
    ..registerLazySingleton(() => SearchRental(sl()))
    ..registerLazySingleton(() => GetRentalView(sl()))
    ..registerLazySingleton(() => SaveRentalView(sl()))

    /* Printer */
    ..registerLazySingleton(() => ConnectToPrinter(sl()))
    ..registerLazySingleton(() => GetBondedDevices(sl()))
    ..registerLazySingleton(() => IsBluetoothEnabled(sl()))
    ..registerLazySingleton(() => OpenBluetoothSetting(sl()))
    ..registerLazySingleton(() => PrintBill(sl()))
    ..registerLazySingleton(() => PrintListEquipment(sl()))
    ..registerLazySingleton(() => GetBluetoothMacAddress(sl()))
    ..registerLazySingleton(() => SaveBluetoothMacAddress(sl()))

    /* Package */
    ..registerLazySingleton(() => AddPackage(sl()))
    ..registerLazySingleton(() => DeletePackage(sl()))
    ..registerLazySingleton(() => GetDetailPackage(sl()))
    ..registerLazySingleton(() => GetListPackage(sl()))
    ..registerLazySingleton(() => UpdatePackage(sl()))

    // Repositories

    /* Authentication */
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    /* Equipment */
    ..registerLazySingleton<EquipmentRepository>(
        () => EquipmentRepositoryImplementation(sl()))
    ..registerLazySingleton<EquipmentSharedPrefsRepository>(
        () => EquipmentSharedPrefsRepositoryImplementation(sl()))
    /* Rental */
    ..registerLazySingleton<RentalRepository>(
        () => RentalRepositoryImplementation(sl()))
    ..registerLazySingleton<RentalSharedPrefsRepository>(
        () => RentalSharedPrefsRepositoryImplementation(sl()))
    /* Printer */
    ..registerLazySingleton<PrinterRepository>(
        () => PrinterRepositoryImplementation(sl()))
    /* Package */
    ..registerLazySingleton<PackageRepository>(
        () => PackageRepositoryImplementation(sl()))

    // Data Sources

    /* Authentication */
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl(), sl()))
    /* Equipment */
    ..registerLazySingleton<EquipmentRemoteDataSource>(
        () => EquipmentRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<EquipmentSharedPrefsRemoteDataSource>(
        () => EquipmentSharedRemoteDataSrcImpl(sl()))
    /* Rental */
    ..registerLazySingleton<RentalRemoteDataSource>(
        () => RentalRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<RentalSharedPrefsRemoteDataSource>(
        () => RentalSharedPrefsRemoteDataSrcImpl(sl()))
    /* Printer */
    ..registerLazySingleton<PrinterRemoteDataSource>(
        () => PrinterRemoteDataSrcImpl(sl()))
    /* Package */
    ..registerLazySingleton<PackageRemoteDataSource>(
        () => PackageRemoteDataSrcImpl(sl()))

    // External Dependencies
    ..registerLazySingleton(() => supabase.Supabase.instance.client.auth)
    ..registerLazySingleton(() => supabase.Supabase.instance.client)
    ..registerLazySingletonAsync<SharedPreferences>(
        () => SharedPreferences.getInstance())
    ..isReady<SharedPreferences>();
}
