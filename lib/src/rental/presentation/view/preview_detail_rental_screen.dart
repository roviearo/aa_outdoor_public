import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/router.dart';
import '../../../package/domain/entities/package.dart';
import '../../domain/entities/rental.dart';
import '../cubit/detail_rental/detail_rental_cubit.dart';

class PreviewDetailRentalScreen extends StatefulWidget {
  const PreviewDetailRentalScreen({super.key});

  @override
  State<PreviewDetailRentalScreen> createState() =>
      _PreviewDetailRentalScreenState();
}

class _PreviewDetailRentalScreenState extends State<PreviewDetailRentalScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  double heightRental = 0;
  final GlobalKey rentalDetailKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          rentalDetailKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          heightRental = renderBox
              .size.height; // Get the height of the RentalDetail widget
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DetailRentalCubit, DetailRentalState>(
          builder: (context, state) {
            final rental = state.rental;

            return Column(
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BackButton(),
                      Text(
                        'Preview Pesanan',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      IconButton(
                        onPressed: () async {
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
                            )),
                          );

                          final now = DateTime.now();
                          if (heightRental <= screenSize.height) {
                            await screenshotController
                                .captureFromWidget(
                                    Material(
                                      child: RentalDetail(
                                        screenSize: screenSize,
                                        rental: rental,
                                      ),
                                    ),
                                    pixelRatio:
                                        MediaQuery.of(context).devicePixelRatio,
                                    delay: const Duration(seconds: 1))
                                .then((Uint8List? image) async {
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              final imagePath =
                                  await File('${directory.path}/$now.png')
                                      .create();
                              await imagePath.writeAsBytes(image!);

                              await Share.shareXFiles(
                                [XFile('${directory.path}/$now.png')],
                                text:
                                    'Nota atas nama *${rental.name}* \n*${Constants.dateFormat.format(rental.createdAt)}* \n*Rp ${Constants.formatPrice.format(rental.totalPrice)}* \n\nTerima Kasih\nhttps://instagram.com/aa__outdoor/',
                              );
                            }).whenComplete(() => router.pop());
                          } else {
                            await screenshotController
                                .captureFromLongWidget(
                                    Material(
                                      child: RentalDetail(
                                        screenSize: screenSize,
                                        rental: rental,
                                      ),
                                    ),
                                    pixelRatio:
                                        MediaQuery.of(context).devicePixelRatio,
                                    delay: const Duration(seconds: 1))
                                .then((Uint8List? image) async {
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              final imagePath =
                                  await File('${directory.path}/$now.png')
                                      .create();
                              await imagePath.writeAsBytes(image!);

                              await Share.shareXFiles(
                                [XFile('${directory.path}/$now.png')],
                                text:
                                    'Nota atas nama *${rental.name}* \n*${Constants.dateFormat.format(rental.createdAt)}* \n*Rp ${Constants.formatPrice.format(rental.totalPrice)}* \n\nTerima Kasih\nhttps://instagram.com/aa__outdoor/',
                              );
                            }).whenComplete(() => router.pop());
                          }
                        },
                        icon: SvgPicture.asset(
                          'icons/share.svg',
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Screenshot(
                      controller: screenshotController,
                      child: RentalDetail(
                        screenSize: screenSize,
                        rental: rental,
                        key: rentalDetailKey,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class RentalDetail extends StatelessWidget {
  const RentalDetail({
    super.key,
    required this.screenSize,
    required this.rental,
  });

  final Size screenSize;
  final Rental rental;

  @override
  Widget build(BuildContext context) {
    int? totalItemEquipment =
        rental.listEquipment?.fold(0, (sum, item) => sum! + item.qtyRental!);
    int? totalItemEquipmentPackage = rental.listPackage?.fold(
      0,
      (previousValue, element) =>
          previousValue! +
          element.listEquipment.fold(
            0,
            (previousValue, element) => previousValue + element.qtyRental!,
          ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Image.asset(
              'images/logo_polos_aa_large.png',
              width: screenSize.width * .3,
            ),
          ),
          const Divider(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Constants.dateFormat.format(rental.createdAt),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    Constants.hourFormat.format(rental.createdAt),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * .5 - 40,
                    ),
                    child: Text(
                      rental.name,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 2),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * .5 - 40,
                    ),
                    child: Text(
                      rental.address ?? '',
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 25,
          ),
          for (int i = 0; i < rental.listPackage!.length; i++)
            ListPackagePreviewRental(
              package: rental.listPackage![i],
              screenSize: screenSize,
            ),
          for (int i = 0; i < rental.listEquipment!.length; i++)
            ListPreviewRental(
              name: rental.listEquipment![i].name,
              qty: rental.listEquipment![i].qtyRental!,
              price: rental.listEquipment![i].price,
              screenSize: screenSize,
            ),
          const Divider(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Qty : ${totalItemEquipment! + totalItemEquipmentPackage!}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                'Lamanya Sewa: ${rental.endDate.difference(rental.startDate).inDays} Hari',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                'Rp ${Constants.formatPrice.format(rental.totalPrice)}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Hubungi Kami di :',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'icons/ig.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                ' : aa__outdoor',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'icons/wa.svg',
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                ' : 0821-3109-3416',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ListPreviewRental extends StatelessWidget {
  const ListPreviewRental({
    super.key,
    required this.name,
    required this.qty,
    required this.price,
    required this.screenSize,
  });
  final String name;
  final int qty;
  final int price;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenSize.width * .5 - 40,
              ),
              child: Text(
                name,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 3),
              child: Text(
                '$qty x ${Constants.formatPrice.format(price)}',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        Text(
          'Rp ${Constants.formatPrice.format(qty * price)}',
          overflow: TextOverflow.clip,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class ListPackagePreviewRental extends StatelessWidget {
  const ListPackagePreviewRental({
    super.key,
    required this.package,
    required this.screenSize,
  });
  final Package package;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenSize.width * .5,
              ),
              child: Text(
                package.name,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            for (int i = 0; i < package.listEquipment.length; i++)
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '${package.listEquipment[i].qtyRental} x ${package.listEquipment[i].name}',
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ),
        Text(
          'Rp ${Constants.formatPrice.format(package.packageQty! * package.totalPrice)}',
          overflow: TextOverflow.clip,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
