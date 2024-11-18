import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/rental_card.dart';
import '../cubit/rental_view/rental_view_cubit.dart';
import '../cubit/rentals/rentals_cubit.dart';
import '../widget/rental_status_card.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<RentalViewCubit, RentalViewState>(
          builder: (context, state) {
            final prefs = state.rentalView;

            return Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const BackButton(),
                    const Expanded(child: SizedBox.shrink()),
                    Image.asset(
                      'images/logo_polos_aa.png',
                      width: 45,
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    const SizedBox(width: 60),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Row(
                    children: [
                      RentalStatusCard(
                        title: 'Belum Selesai',
                        selected: prefs == 0,
                        onTap: () {
                          if (prefs != 0) {
                            context.read<RentalViewCubit>().writeRentalView(0);
                            context.read<RentalsCubit>().loadUnfinishedRental();
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      RentalStatusCard(
                        title: 'Selesai',
                        selected: prefs == 1,
                        onTap: () {
                          if (prefs != 1) {
                            context.read<RentalViewCubit>().writeRentalView(1);
                            context.read<RentalsCubit>().loadFinishedRental();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<RentalsCubit, RentalsState>(
                  builder: (context, state) {
                    if (state.status == RentalsStatus.error) {
                      return const Center(child: Text('Error'));
                    }

                    if (state.status == RentalsStatus.loaded) {
                      final listRental = state.listRental;

                      if (listRental.isEmpty) {
                        return const Expanded(
                          child: Center(
                            child: Text('Tidak ada data'),
                          ),
                        );
                      }

                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: listRental.length,
                          itemBuilder: (context, index) =>
                              RentalCard(rental: listRental[index]),
                        ),
                      );
                    }

                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
