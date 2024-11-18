import 'package:flutter/material.dart';

class LineModalBottomSheet extends StatelessWidget {
  const LineModalBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .2,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
