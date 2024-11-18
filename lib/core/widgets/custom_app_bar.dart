import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../src/printer/presentation/cubit/printer_connection_status/printer_connection_status/printer_connection_status_cubit.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.useLogo,
  });
  final bool useLogo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: Row(
        children: [
          useLogo
              ? Image.asset(
                  'images/logo_polos_aa.png',
                  width: 45,
                )
              : const SizedBox.shrink(),
          useLogo ? const SizedBox(width: 5) : const SizedBox.shrink(),
          SvgPicture.asset(
            'icons/aa_text.svg',
            width: MediaQuery.of(context).size.width * .35,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          BlocBuilder<PrinterConnectionStatusCubit,
              PrinterConnectionStatusState>(
            builder: (context, state) {
              return Tooltip(
                message: state.message,
                child: IconButton(
                  onPressed: () {},
                  icon: state.status == PrinterStatus.connected
                      ? SvgPicture.asset(
                          'icons/printer.svg',
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        )
                      : SvgPicture.asset(
                          'icons/printer_disconnect.svg',
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.outline,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
