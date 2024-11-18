import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../core/utils/constants.dart';
import '../../../equipment/presentation/blocs/category/category_bloc.dart';
import '../../../equipment/presentation/blocs/equipment/equipment_bloc.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../package/presentation/cubit/packages/packages_cubit.dart';
import '../../../printer/presentation/cubit/printer_connection_status/printer_connection_status/printer_connection_status_cubit.dart';
import '../../../rental/presentation/cubit/rentals/rentals_cubit.dart';
import '/core/utils/router.dart';
import '/src/authentication/presentation/bloc/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) async {
          if (state is AuthenticationError) {
            router.pop();
            String errorCode = 'Silahkan hubungi admin anda';

            switch (state.errorCode) {
              case 'invalid_credentials':
                errorCode =
                    'Email atau Password anda salah.\nSilahkan cek kembali.';
                break;
              default:
            }
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(errorCode)));
          }

          if (state is SigningIn) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (state is SignedIn) {
            context.read<HomeCubit>().loadHomeCubit(Constants.rentalUndone);
            context.read<RentalsCubit>().loadUnfinishedRental();
            context.read<CategoryBloc>().add(const LoadListCategory());
            context.read<EquipmentBloc>().add(const LoadListEquipment());
            context.read<PrinterConnectionStatusCubit>().startMonitoring();
            context.read<PackagesCubit>().loadListPackage();
            await Future.delayed(const Duration(seconds: 3))
                .then((value) => router.goNamed('main'));
            router.goNamed('main');
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/logo_polos_aa_large.png',
                      width: MediaQuery.of(context).size.width * .5,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Email'),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tolong diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            isObscure = !isObscure;
                          }),
                          icon: SvgPicture.asset(
                            isObscure ? 'icons/eye_close.svg' : 'icons/eye.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.outline,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      obscureText: isObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tolong diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthenticationBloc>().add(SignInEvent(
                                emailController.text,
                                passwordController.text,
                              ));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
