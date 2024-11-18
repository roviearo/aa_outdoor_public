import 'package:flutter/material.dart';

class EquipmentCategoryCard extends StatelessWidget {
  const EquipmentCategoryCard({
    super.key,
    required this.isSelected,
    required this.name,
    required this.onTap,
  });

  final VoidCallback onTap;
  final bool isSelected;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: isSelected
            ? Theme.of(context).colorScheme.secondaryContainer
            : Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    )
                  : Border.all(
                      color: Theme.of(context).disabledColor,
                    ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer
                              : Theme.of(context).disabledColor,
                        ),
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
