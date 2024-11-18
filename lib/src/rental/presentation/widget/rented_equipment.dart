import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class RentedEquipment extends StatelessWidget {
  const RentedEquipment({
    super.key,
    required this.name,
    required this.qty,
    required this.price,
  });
  final String name;
  final int? qty;
  final int? price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '$qty x ${Constants.formatPrice.format(price)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox.shrink()),
          Text(
            'Rp ${Constants.formatPrice.format(price! * qty!)}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
