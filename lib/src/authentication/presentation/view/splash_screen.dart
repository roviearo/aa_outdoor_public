import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../package/presentation/cubit/packages/packages_cubit.dart';
import '../../../printer/presentation/cubit/printer_connection_status/printer_connection_status/printer_connection_status_cubit.dart';
import '../../../rental/presentation/cubit/rentals/rentals_cubit.dart';
import '/core/utils/router.dart';
import '/src/authentication/presentation/bloc/authentication_bloc.dart';
import '../../../equipment/presentation/blocs/category/category_bloc.dart';
import '../../../equipment/presentation/blocs/equipment/equipment_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state is Authenticated) {
          context.read<HomeCubit>().loadHomeCubit(Constants.rentalUndone);
          context.read<RentalsCubit>().loadUnfinishedRental();
          context.read<CategoryBloc>().add(const LoadListCategory());
          context.read<EquipmentBloc>().add(const LoadListEquipment());
          context.read<PackagesCubit>().loadListPackage();
          if (state.macAddress != null) {
            context
                .read<PrinterConnectionStatusCubit>()
                .connectToPrinter(state.macAddress!);
          } else {
            context.read<PrinterConnectionStatusCubit>().startMonitoring();
          }
          await Future.delayed(const Duration(seconds: 3))
              .then((value) => router.goNamed('main'));
        } else {
          await Future.delayed(const Duration(seconds: 3))
              .then((value) => router.goNamed('login'));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo_polos_aa_large.png',
                    width: MediaQuery.of(context).size.width * .5,
                  ),
                  const SizedBox(height: 30),
                  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
