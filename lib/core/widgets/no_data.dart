import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline_rounded,
          size: MediaQuery.of(context).size.width * .2,
          color: Theme.of(context).disabledColor,
        ),
        Text(
          'Tidak ada data',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).disabledColor,
              ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .15,
        )
      ],
    ));
  }
}
