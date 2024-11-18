import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/router.dart';
import '../../../rental/domain/entities/rental.dart';
import '../../../rental/presentation/cubit/detail_rental/detail_rental_cubit.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    required this.rental,
    this.color,
  });

  final Rental rental;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.read<DetailRentalCubit>().loadDetailRental(rental);
            router.pushNamed('detail_rental');
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).disabledColor,
              ),
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .45,
                  ),
                  child: Text(
                    rental.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color ==
                                  Theme.of(context).colorScheme.errorContainer
                              ? Theme.of(context).colorScheme.onErrorContainer
                              : null,
                        ),
                  ),
                ),
                Text(
                  Constants.dateFormat.format(rental.endDate),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color ==
                                Theme.of(context).colorScheme.errorContainer
                            ? Theme.of(context).colorScheme.onErrorContainer
                            : null,
                      ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
