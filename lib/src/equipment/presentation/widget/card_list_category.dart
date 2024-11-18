import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blocs/category/category_bloc.dart';

class CardListCategory extends StatefulWidget {
  const CardListCategory({
    super.key,
    required this.id,
    required this.name,
    required this.onDoneEditTap,
    required this.onRemoveTap,
  });
  final String id;
  final String name;
  final VoidCallback onDoneEditTap;
  final VoidCallback onRemoveTap;

  @override
  State<CardListCategory> createState() => _CardListCategoryState();
}

class _CardListCategoryState extends State<CardListCategory> {
  TextEditingController categoryController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    categoryController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              isEditing
                  ? Expanded(
                      child: TextFormField(
                        controller: categoryController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    )
                  : Text(
                      widget.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
              isEditing
                  ? const SizedBox(width: 20)
                  : const Expanded(child: SizedBox.shrink()),
              isEditing
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isEditing = false;
                        });
                        context.read<CategoryBloc>().add(UpdateCategoryEvent(
                            widget.id, categoryController.text));
                      },
                      behavior: HitTestBehavior.opaque,
                      child: SvgPicture.asset(
                        'icons/check_square.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: SvgPicture.asset(
                        'icons/edit.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: widget.onRemoveTap,
                behavior: HitTestBehavior.opaque,
                child: SvgPicture.asset(
                  'icons/minus.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.error,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 30,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
