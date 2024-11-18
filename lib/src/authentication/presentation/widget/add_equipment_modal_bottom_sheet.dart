import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/router.dart';
import '../../../../core/widgets/line_modal_bottom_sheet.dart';
import '../../../../core/widgets/number_text_form_field.dart';
import '../../../../core/widgets/string_text_form_field.dart';
import '../../../equipment/domain/entities.dart';
import '../../../equipment/presentation/blocs/category/category_bloc.dart';
import '../../../equipment/presentation/blocs/equipment/equipment_bloc.dart';
import '../../../equipment/presentation/cubits/equipment_shared_prefs/equipment_shared_prefs_cubit.dart';

class AddEquipmentModalBottomSheet extends StatefulWidget {
  const AddEquipmentModalBottomSheet({
    super.key,
  });

  @override
  State<AddEquipmentModalBottomSheet> createState() =>
      _AddEquipmentModalBottomSheetState();
}

class _AddEquipmentModalBottomSheetState
    extends State<AddEquipmentModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockQtyController = TextEditingController();

  late String firstCategoryId;
  late String selectedCategoryId;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EquipmentBloc, EquipmentState>(
      listener: (context, state) {
        if (state is AddEquipmentSucceeded) {
          context.read<EquipmentSharedPrefsCubit>().writeEquipmentCategory(-1);
          context.read<EquipmentBloc>().add(const LoadListEquipment());
          router.pop();
        }

        if (state is EquipmentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
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
                    firstCategoryId = listCategory.first.id;

                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Kategori Peralatan',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      value: listCategory.first,
                      items: listCategory.map((Category value) {
                        return DropdownMenuItem<Category>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategoryId = value!.id;
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
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<EquipmentBloc>().add(AddNewEquipment(
                          name: nameController.text,
                          price: priceController.text,
                          stockQty: stockQtyController.text,
                          categoryId: selectedCategoryId.isEmpty
                              ? firstCategoryId
                              : selectedCategoryId,
                        ));
                  }
                },
                child: const Text('Simpan'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
