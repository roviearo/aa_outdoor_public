import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/router.dart';
import '../cubit/add_rental/add_rental_cubit.dart';

class DetailCustomerRentalScreen extends StatefulWidget {
  const DetailCustomerRentalScreen({super.key});

  @override
  State<DetailCustomerRentalScreen> createState() =>
      _DetailCustomerRentalScreenState();
}

class _DetailCustomerRentalScreenState
    extends State<DetailCustomerRentalScreen> {
  List<String> idCardList = ['KTP', 'KARTU PELAJAR', 'SIM', 'Lainnya'];
  late String selectedIdCard;
  TextEditingController nameIdCardController = TextEditingController();

  bool useSameName = false;

  @override
  void initState() {
    super.initState();
    selectedIdCard = idCardList.first;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<AddRentalCubit, AddRentalState>(
          builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(),
                            Text(
                              'Detail Pelanggan',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'icons/reset.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Nama Pelanggan',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                          ),
                          textCapitalization: TextCapitalization.words,
                          initialValue: state.name,
                          onChanged: (value) =>
                              context.read<AddRentalCubit>().nameChanged(value),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Alamat',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                          ),
                          initialValue: state.address,
                          onChanged: (value) => context
                              .read<AddRentalCubit>()
                              .addressChanged(value),
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Nomor Telepon',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          initialValue: state.phoneNumber,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) => context
                              .read<AddRentalCubit>()
                              .phoneNumberChanged(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'Nama di Kartu Identitas',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .7 -
                                          25,
                                  child: TextFormField(
                                    controller: nameIdCardController,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 10,
                                      ),
                                      suffixIcon: Checkbox(
                                        value: useSameName,
                                        onChanged: (value) {
                                          setState(() {
                                            useSameName = !useSameName;
                                            if (useSameName) {
                                              nameIdCardController.text =
                                                  state.name;
                                              context
                                                  .read<AddRentalCubit>()
                                                  .nameIdCardChanged(
                                                      state.name);
                                            } else {
                                              nameIdCardController.text = '';
                                              context
                                                  .read<AddRentalCubit>()
                                                  .nameIdCardChanged('');
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    onChanged: (value) => context
                                        .read<AddRentalCubit>()
                                        .nameIdCardChanged(value),
                                    textCapitalization:
                                        TextCapitalization.words,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  'Jenis Kartu',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .3 -
                                          25,
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 10,
                                      ),
                                    ),
                                    value: selectedIdCard,
                                    items: idCardList
                                        .map<DropdownMenuItem<String>>(
                                          (String value) => DropdownMenuItem(
                                            value: value,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(value),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          '*Centang jika nama pelanggan sama dengan di kartu identitas',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                'icons/calendar_outline.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).disabledColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            filled: false,
                            enabled: false,
                            border: const UnderlineInputBorder(),
                            enabledBorder: const UnderlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(),
                            contentPadding: const EdgeInsets.only(top: 15),
                          ),
                          initialValue:
                              '${Constants.dateFormat.format(state.startDate ?? DateTime.now())} - ${Constants.dateFormat.format(state.endDate ?? DateTime.now().add(const Duration(days: 1)))}',
                          mouseCursor: MouseCursor.uncontrolled,
                          readOnly: true,
                          cursorWidth: 0,
                          magnifierConfiguration:
                              TextMagnifierConfiguration.disabled,
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  router.pushNamed('payment_rental');
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14.0),
                                  child: Text('Pembayaran'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
