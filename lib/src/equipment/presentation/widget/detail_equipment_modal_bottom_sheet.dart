import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/router.dart';
import '../../../../core/widgets/line_modal_bottom_sheet.dart';
import '../../../../core/widgets/number_text_form_field.dart';
import '../../../../core/widgets/string_text_form_field.dart';
import '../../../equipment/domain/entities.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/equipment/equipment_bloc.dart';
import '../cubits/equipment_shared_prefs/equipment_shared_prefs_cubit.dart';

class DetailEquipmentModalBottomSheet extends StatefulWidget {
  const DetailEquipmentModalBottomSheet({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  State<DetailEquipmentModalBottomSheet> createState() =>
      _DetailEquipmentModalBottomSheetState();
}

class _DetailEquipmentModalBottomSheetState
    extends State<DetailEquipmentModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockQtyController = TextEditingController();

  late Category selectedCategory;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.equipment.name;
    priceController.text = widget.equipment.price.toString();
    stockQtyController.text = widget.equipment.stockQty.toString();
    selectedCategory = widget.equipment.category;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EquipmentBloc, EquipmentState>(
      listener: (context, state) {
        if (state is UpdateEquipmentSucceeded) {
          context.read<EquipmentSharedPrefsCubit>().writeEquipmentCategory(-1);
          context.read<EquipmentBloc>().add(const LoadListEquipment());
          router.pop();
        }

        if (state is EquipmentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is UpdateEquipmentLoading ||
            state is DeleteEquipmentLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LineModalBottomSheet(),
              const SizedBox(height: 25),
              StringTextFormField(
                controller: nameController,
                labelText: 'Nama Peralatan',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              NumberTextFormField(
                controller: priceController,
                labelText: 'Harga Peralatan',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is ListCategoryLoaded) {
                    final listCategory = state.listCategory;

                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Kategori Peralatan',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      value: selectedCategory,
                      items: listCategory.map((Category value) {
                        return DropdownMenuItem<Category>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 10),
              NumberTextFormField(
                controller: stockQtyController,
                labelText: 'Jumlah Stok',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<EquipmentBloc>().add(UpdateEquipmentEvent(
                              id: widget.equipment.id,
                              name: nameController.text,
                              price: priceController.text,
                              stockQty: stockQtyController.text,
                              categoryId: selectedCategory.id,
                            ));
                      }
                    },
                    child: const Text('Simpan'),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Yakin hapus ${widget.equipment.name} ?',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .075,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(child: SizedBox()),
                                      TextButton(
                                        onPressed: () {
                                          router.pop();
                                        },
                                        child: const Text('Tidak'),
                                      ),
                                      const SizedBox(width: 10),
                                      TextButton(
                                        onPressed: () {
                                          if (widget.equipment.usedQty == 0) {
                                            context.read<EquipmentBloc>().add(
                                                DeleteEquipmentEvent(
                                                    id: widget.equipment.id));
                                            router.pop();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Peralatan tidak bisa dihapus karena ada yang belum dikembalikan.',
                                                ),
                                              ),
                                            );
                                          }
                                          router.pop();
                                        },
                                        child: const Text('Ya'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        'icons/trash.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor,
                          BlendMode.srcIn,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
