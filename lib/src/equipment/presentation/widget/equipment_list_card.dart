import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class EquipmentListCard extends StatelessWidget {
  const EquipmentListCard({
    super.key,
    required this.title,
    required this.stock,
    required this.price,
    required this.onTap,
  });

  final String title;
  final String stock;
  final int price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    late String firstInitial;
    late String secondInitial;

    List<String> listTitle = title.split(' ');
    if (listTitle.length == 1) {
      firstInitial = listTitle[0][0];
      secondInitial = listTitle[0][1];
    } else {
      firstInitial = listTitle[0][0];
      secondInitial = listTitle[1][0];
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).disabledColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * .11,
                ),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${firstInitial.toUpperCase()}${secondInitial.toUpperCase()}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .425,
                    ),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'stok : $stock',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const Expanded(child: SizedBox.shrink()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'Rp ${Constants.formatPrice.format(price)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
