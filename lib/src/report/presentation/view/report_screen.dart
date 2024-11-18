import 'package:aa_outdoor/core/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(useLogo: true),
          InkWell(
            onTap: () {
              router.pushNamed('more_report');
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'icons/general_report.svg',
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Laporan Umum',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const Divider(indent: 20, endIndent: 20, height: 0),
          InkWell(
            onTap: () {},
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'icons/all_report.svg',
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Laporan Semua Transaksi',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const Divider(indent: 20, endIndent: 20, height: 0),
          InkWell(
            onTap: () {},
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'icons/transaction_report.svg',
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Laporan per Peralatan',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const Divider(indent: 20, endIndent: 20, height: 0),
        ],
      ),
    );
  }
}
