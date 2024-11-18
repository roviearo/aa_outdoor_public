import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/constants.dart';
import '../../domain/entities/package.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.package,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  final Package package;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).disabledColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                package.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const Expanded(child: SizedBox.shrink()),
              IconButton(
                onPressed: onEditTap,
                icon: SvgPicture.asset(
                  'icons/edit.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              IconButton(
                onPressed: onDeleteTap,
                icon: SvgPicture.asset(
                  'icons/trash_outline.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                package.listEquipment.length,
                (index) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5 - 40,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 - 80,
                        child: Text(
                          '· ${package.listEquipment[index].name}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'x ${package.listEquipment[index].qtyRental}',
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Harga',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Rp ${Constants.formatPrice.format(package.totalPrice)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
