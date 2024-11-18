import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class EquipmentGridCard extends StatelessWidget {
  const EquipmentGridCard({
    super.key,
    required this.name,
    required this.price,
    required this.stockQty,
    this.qty,
    required this.onTap,
    required this.onLongPress,
  });

  final String name;
  final int price;
  final int stockQty;
  final int? qty;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: qty != 0,
      label: Center(child: Text(qty.toString())),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      offset: const Offset(-10, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withAlpha(50),
              offset: const Offset(0, 2),
              blurRadius: 3,
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            onLongPress: onLongPress,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * .3333 - 20,
                  height: 80,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * .3333 - 20,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rp ${Constants.formatPrice.format(price)}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      Text(
                        'Stok : $stockQty',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).disabledColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
