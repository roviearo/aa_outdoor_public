import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../equipment/domain/entities/equipment.dart';

class SelectedEquipmentPackage extends StatelessWidget {
  const SelectedEquipmentPackage({
    super.key,
    required this.equipment,
    required this.qty,
    required this.onRemoveTap,
  });

  final Equipment equipment;
  final String qty;
  final VoidCallback onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      equipment.name,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Text(
                'qty :',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .1,
                child: Column(
                  children: [
                    Text(
                      qty,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Divider(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onRemoveTap,
                child: SvgPicture.asset(
                  'icons/close_circle.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
