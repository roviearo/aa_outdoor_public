import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/router.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../authentication/presentation/bloc/authentication_bloc.dart';
import '../../../equipment/presentation/blocs/category/category_bloc.dart';
import '../../../package/presentation/cubit/edit_package/edit_package_cubit.dart';
import '../../../package/presentation/cubit/packages/packages_cubit.dart';
import '../../../printer/presentation/cubit/bluetooth_status/bluetooth_status_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(useLogo: false),
          Image.asset(
            'images/logo_polos_aa_large.png',
            width: MediaQuery.of(context).size.width * .4,
          ),
          const SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * .2,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              context.read<CategoryBloc>().add(const LoadListCategory());
              router.pushNamed('category');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori Peralatan',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SvgPicture.asset(
                    'icons/chevron_right.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              context.read<EditPackageCubit>().loadListEquipment();
              context.read<PackagesCubit>().loadListPackage();
              router.pushNamed('package');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilihan Paket',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SvgPicture.asset(
                    'icons/chevron_right.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              context.read<BluetoothStatusCubit>().startCheckBluetooth();
              router.pushNamed('printer_setting');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Printer',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SvgPicture.asset(
                    'icons/chevron_right.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              router.pushNamed('theme_setting');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tampilan Tema',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SvgPicture.asset(
                    'icons/chevron_right.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              context.read<AuthenticationBloc>().add(const SignOutEvent());
              router.goNamed('login');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Logout',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SvgPicture.asset(
                    'icons/chevron_right.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
