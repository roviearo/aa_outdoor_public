import 'package:flutter/material.dart';

class ListDetailRental extends StatelessWidget {
  const ListDetailRental({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .5 - 20,
            child: Text(
              title,
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .5 - 20,
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
