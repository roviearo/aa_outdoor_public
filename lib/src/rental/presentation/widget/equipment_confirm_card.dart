import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/constants.dart';

class EquipmentConfirmCard extends StatelessWidget {
  const EquipmentConfirmCard({
    super.key,
    required this.number,
    required this.title,
    required this.price,
    required this.qty,
    required this.onTap,
    required this.onDeleteTap,
  });

  final int number;
  final String title;
  final int price;
  final int qty;
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;

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
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    number.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  child: Text(
                    '${firstInitial.toUpperCase()}${secondInitial.toUpperCase()}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .57,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      '$qty x ${Constants.formatPrice.format(price)} = Rp ${Constants.formatPrice.format(qty * price)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox.shrink()),
                IconButton(
                  onPressed: onDeleteTap,
                  icon: SvgPicture.asset(
                    'icons/trash_outline.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
