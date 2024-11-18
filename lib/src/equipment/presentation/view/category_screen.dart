import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../core/utils/router.dart';
import '../../../../core/widgets/no_data.dart';
import '../blocs/category/category_bloc.dart';
import '../widget/card_list_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController addCategoryController = TextEditingController();
  bool isAddCategoryEmpty = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        if (context.mounted) {
          context.read<CategoryBloc>().add(const LoadListCategory());
          router.pop();
        }
      },
      child: KeyboardDismisser(
        child: BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryError) {
              context.read<CategoryBloc>().add(const LoadListCategory());
              router.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Kategori tidak bisa dihapus karena ada peralatan yang menggunakan kategori ini.'),
                ),
              );
            }

            if (state is AddCategorySucceeded) {
              context.read<CategoryBloc>().add(const LoadListCategory());
              addCategoryController.clear();
              setState(() {
                isAddCategoryEmpty = true;
              });
            }

            if (state is DeleteCategorySucceeded ||
                state is UpdateCategorySucceeded) {
              context.read<CategoryBloc>().add(const LoadListCategory());
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const BackButton(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  isAddCategoryEmpty = false;
                                });
                              } else {
                                setState(() {
                                  isAddCategoryEmpty = true;
                                });
                              }
                            },
                            controller: addCategoryController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              filled: false,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              hintText: 'Tambah kategori',
                              suffixIcon: isAddCategoryEmpty
                                  ? null
                                  : GestureDetector(
                                      onTap: () {
                                        addCategoryController.clear();
                                        setState(() {
                                          isAddCategoryEmpty = true;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgPicture.asset(
                                          'icons/close_circle.svg',
                                          colorFilter: ColorFilter.mode(
                                            Theme.of(context).disabledColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            autofocus: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          context.read<CategoryBloc>().add(
                              AddCategoryEvent(addCategoryController.text));
                        },
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Icon(Icons.add_rounded),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading ||
                          state is UpdateCategoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is ListCategoryLoaded) {
                        final listCategory = state.listCategory;
                        if (listCategory.isEmpty) {
                          return const NoData();
                        }
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: false,
                            itemCount: listCategory.length,
                            itemBuilder: (context, index) {
                              return CardListCategory(
                                id: listCategory[index].id,
                                name: listCategory[index].name,
                                onDoneEditTap: () {},
                                onRemoveTap: () {
                                  context.read<CategoryBloc>().add(
                                      DeleteCategoryEvent(
                                          listCategory[index].id));
                                },
                              );
                            },
                          ),
                        );
                      }
                      return const Center(child: Text('Error'));
                    },
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
