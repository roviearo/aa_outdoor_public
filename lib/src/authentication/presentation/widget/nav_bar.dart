import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });
  final int pageIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      padding: const EdgeInsets.all(0),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(50),
              offset: const Offset(0, -.5),
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            navItem(
              context,
              'home',
              pageIndex == 0,
              onTap: () => onTap(0),
            ),
            navItem(
              context,
              'equipment',
              pageIndex == 1,
              onTap: () => onTap(1),
            ),
            const SizedBox(width: 80),
            navItem(
              context,
              'report',
              pageIndex == 2,
              onTap: () => onTap(2),
            ),
            navItem(
              context,
              'setting',
              pageIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(BuildContext context, String assetName, bool selected,
      {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          selected ? "icons/$assetName.svg" : "icons/${assetName}_outline.svg",
          colorFilter: ColorFilter.mode(
            selected
                ? Theme.of(context).iconTheme.color!
                : Theme.of(context).disabledColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
