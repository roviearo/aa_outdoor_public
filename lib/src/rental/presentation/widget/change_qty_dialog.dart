import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../core/utils/constants.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../cubit/add_rental/add_rental_cubit.dart';

class ChangeQtyDialog extends StatefulWidget {
  const ChangeQtyDialog({
    super.key,
    required this.equipment,
    required this.listEquipment,
  });

  final Equipment equipment;
  final List<Equipment> listEquipment;

  @override
  State<ChangeQtyDialog> createState() => _ChangeQtyDialogState();
}

class _ChangeQtyDialogState extends State<ChangeQtyDialog> {
  List<Equipment> editedSelectedEquipment = [];
  TextEditingController itemCountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    editedSelectedEquipment.addAll(widget.listEquipment);
    itemCountController.text = editedSelectedEquipment
        .where((equipment) => equipment == widget.equipment)
        .length
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    late String firstInitial;
    late String secondInitial;

    List<String> listTitle = widget.equipment.name.split(' ');

    if (listTitle.length == 1) {
      firstInitial = listTitle[0][0];
      secondInitial = listTitle[0][1];
    } else {
      firstInitial = listTitle[0][0];
      secondInitial = listTitle[1][0];
    }

    return KeyboardDismisser(
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    child: Text(
                      '${firstInitial.toUpperCase()}${secondInitial.toUpperCase()}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          widget.equipment.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Text(
                        'Rp ${Constants.formatPrice.format(widget.equipment.price)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        editedSelectedEquipment.remove(widget.equipment);
                        itemCountController.text = editedSelectedEquipment
                            .where((equipment) => equipment == widget.equipment)
                            .length
                            .toString();
                      });
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .2,
                    child: TextFormField(
                      controller: itemCountController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                      maxLength: 3,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        editedSelectedEquipment.add(widget.equipment);
                        itemCountController.text = editedSelectedEquipment
                            .where((equipment) => equipment == widget.equipment)
                            .length
                            .toString();
                      });
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          editedSelectedEquipment.removeWhere(
                              (equipment) => equipment == widget.equipment);

                          context
                              .read<AddRentalCubit>()
                              .selectedEquipmentChanged(
                                  editedSelectedEquipment);

                          context.read<AddRentalCubit>().totalPrice();
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).disabledColor),
                        ),
                        child: const Text('Hapus'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          context
                              .read<AddRentalCubit>()
                              .selectedEquipmentChanged(
                                  editedSelectedEquipment);
                          context.read<AddRentalCubit>().totalPrice();
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
