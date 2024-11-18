import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../package/domain/entities/package.dart';

class PackageListCard extends StatelessWidget {
  const PackageListCard({
    super.key,
    required this.package,
    this.qty,
    required this.onTap,
    required this.onLongPress,
  });

  final Package package;
  final int? qty;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    late String firstInitial;
    late String secondInitial;

    List<String> listTitle = package.name.split(' ');

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
        child: ExpandableNotifier(
          child: ScrollOnExpand(
            theme: ExpandableThemeData(
              tapBodyToExpand: true,
              tapHeaderToExpand: true,
              inkWellBorderRadius: BorderRadius.circular(10),
            ),
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                inkWellBorderRadius: BorderRadius.circular(10),
              ),
              collapsed: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).disabledColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${firstInitial.toUpperCase()}${secondInitial.toUpperCase()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  package.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Rp ${Constants.formatPrice.format(package.totalPrice)}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox.shrink()),
                          qty == 0
                              ? const SizedBox.shrink()
                              : Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).disabledColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    qty.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                    ExpandableButton(
                      theme: const ExpandableThemeData(
                        inkWellBorderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              expanded: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).disabledColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${firstInitial.toUpperCase()}${secondInitial.toUpperCase()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  package.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Rp ${Constants.formatPrice.format(package.totalPrice)}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox.shrink()),
                          qty == 0
                              ? const SizedBox.shrink()
                              : Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).disabledColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    qty.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: List.generate(
                          package.listEquipment.length,
                          (index) => SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5 - 40,
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          70,
                                  child: Text(
                                    '· ${package.listEquipment[index].name}',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'x ${package.listEquipment[index].qtyRental}',
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.start,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ExpandableButton(
                      theme: const ExpandableThemeData(
                        inkWellBorderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
