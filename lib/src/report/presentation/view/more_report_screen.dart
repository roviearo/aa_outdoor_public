import 'package:flutter/material.dart';

class MoreReportScreen extends StatelessWidget {
  const MoreReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Text(
                  'Laporan',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pendapatan',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                    Text('Rp 1.304.000',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                DropdownMenu(
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  initialSelection: 'test1',
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 'test1', label: 'test1'),
                    DropdownMenuEntry(value: 'test2', label: 'test2'),
                    DropdownMenuEntry(value: 'test3', label: 'test3'),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
