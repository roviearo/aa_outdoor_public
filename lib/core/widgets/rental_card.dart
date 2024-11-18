import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/rental/domain/entities/rental.dart';
import '../../src/rental/presentation/cubit/detail_rental/detail_rental_cubit.dart';
import '../utils/constants.dart';
import '../utils/router.dart';

class RentalCard extends StatelessWidget {
  const RentalCard({
    super.key,
    required this.rental,
    this.color,
  });

  final Rental rental;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    int? totalItemEquipment =
        rental.listEquipment?.fold(0, (sum, item) => sum! + item.qtyRental!);
    int? totalItemEquipmentPackage = rental.listPackage?.fold(
      0,
      (previousValue, element) =>
          previousValue! +
          element.listEquipment.fold(
            0,
            (previousValue, element) => previousValue + element.qtyRental!,
          ),
    );
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.read<DetailRentalCubit>().loadDetailRental(rental);
            router.pushNamed('detail_rental');
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(10),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .45,
                      ),
                      child: Text(
                        rental.name,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: color ==
                                          Theme.of(context)
                                              .colorScheme
                                              .errorContainer
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer
                                      : null,
                                ),
                      ),
                    ),
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .3,
                          ),
                          child: Text(
                            'Rp ${Constants.formatPrice.format(rental.totalPrice)}',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        const Text('  ·  '),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .2,
                          ),
                          child: Text(
                            '${totalItemEquipment! + totalItemEquipmentPackage!} Item',
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).disabledColor,
                                    ),
                          ),
                        ),
                      ],
                    )
                  ],
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
