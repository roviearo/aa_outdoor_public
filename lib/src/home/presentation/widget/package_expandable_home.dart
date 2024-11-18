import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../package/domain/entities/package.dart';

class PackageExpandableHome extends StatelessWidget {
  const PackageExpandableHome({
    super.key,
    required this.package,
    required this.onTap,
  });

  final Package package;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: ExpandableNotifier(
        child: ScrollOnExpand(
          theme: ExpandableThemeData(
            tapBodyToExpand: true,
            tapHeaderToExpand: true,
            inkWellBorderRadius: BorderRadius.circular(10),
          ),
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              tapBodyToExpand: true,
              tapHeaderToExpand: true,
              inkWellBorderRadius: BorderRadius.circular(10),
            ),
            collapsed: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).disabledColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ExpandableButton(
                    theme: ExpandableThemeData(
                      useInkWell: false,
                      inkWellBorderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .55,
                            child: Text(
                              package.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          ),
                          const Expanded(child: SizedBox.shrink()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Rp ${Constants.formatPrice.format(package.totalPrice)}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10, right: 10, bottom: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Text(
                            package.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Rp ${Constants.formatPrice.format(package.totalPrice)}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
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
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    75,
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
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: FilledButton(
                      onPressed: onTap,
                      child: Text(
                        'Gunakan paket ini',
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ExpandableButton(
                    theme: const ExpandableThemeData(
                      useInkWell: false,
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
    );
  }
}
