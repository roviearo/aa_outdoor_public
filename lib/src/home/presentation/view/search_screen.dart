import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../rental/presentation/cubit/search_rental/search_rental_cubit.dart';
import '../widget/search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const BackButton(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 20,
                        bottom: 10,
                      ),
                      child: TextFormField(
                        onChanged: (query) {
                          if (query.isNotEmpty) {
                            context
                                .read<SearchRentalCubit>()
                                .searchRental(query);
                          } else {
                            context.read<SearchRentalCubit>().clearSearch();
                          }
                        },
                        decoration: InputDecoration(
                          filled: false,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          hintText:
                              'Cari ${selectedIndex == 0 ? 'rental' : 'peralatan'}',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              top: 12.0,
                              bottom: 12.0,
                              right: 10,
                            ),
                            child: SvgPicture.asset(
                              'icons/search.svg',
                              width: 18,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).disabledColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'icons/filter.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).disabledColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SearchFilterCard(
                      isSelected: selectedIndex == 0,
                      name: 'Rental',
                      onTap: () {
                        if (selectedIndex != 0) {
                          setState(() {
                            selectedIndex = 0;
                          });
                        }
                      },
                    ),
                    const Expanded(child: SizedBox()),
                    SearchFilterCard(
                      isSelected: selectedIndex == 1,
                      name: 'Peralatan',
                      onTap: () {
                        if (selectedIndex != 1) {
                          setState(() {
                            selectedIndex = 1;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<SearchRentalCubit, SearchRentalState>(
                builder: (context, state) {
                  final searchResult = state.searchResult;

                  if (state.searchResult.isEmpty) {
                    return const Center(child: Text('Data tidak ditemukan'));
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) => SearchCard(
                        rental: searchResult[index],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchFilterCard extends StatelessWidget {
  const SearchFilterCard({
    super.key,
    required this.isSelected,
    required this.name,
    required this.onTap,
  });
  final bool isSelected;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .5 - 40,
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: !isSelected
            ? Border.all(color: Theme.of(context).disabledColor)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * .16,
            ),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
