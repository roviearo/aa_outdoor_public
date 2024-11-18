import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class ChooseEquipmentListCard extends StatelessWidget {
  const ChooseEquipmentListCard({
    super.key,
    required this.title,
    required this.price,
    this.qty,
    required this.onTap,
    required this.onLongPress,
  });

  final String title;
  final int price;
  final int? qty;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

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
        onLongPress: onLongPress,
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
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${firstInitial.toUpperCase()}${secondInitial.toUpperCase()}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                ),
              ),
              const SizedBox(width: 10),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Rp ${Constants.formatPrice.format(price)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              qty == 0
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).disabledColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        qty.toString(),
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
