import 'package:aa_outdoor/src/equipment/presentation/cubits/search_equipment/search_equipment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        child: TextFormField(
          onChanged: (query) {
            if (query.isNotEmpty) {
              context.read<SearchEquipmentCubit>().searchEquipment(query);
            } else {
              context.read<SearchEquipmentCubit>().clearSearch();
            }
          },
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: const Icon(Icons.close_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
