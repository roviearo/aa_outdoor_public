import 'package:app_settings/app_settings.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/utils/constants.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../../../package/domain/entities/package.dart';
import '../../../rental/domain/entities/rental.dart';

abstract class PrinterRemoteDataSource {
  Future<bool> connectToPrinter(String macAddress);
  Future<List<BluetoothInfo>> getBondedDevices();
  void openBluetoothSetting();
  Future<bool> isBluetoothEnabled();
  Future<bool> printBill(Rental rental, int? payment, int? change);
  Future<bool> printListEquipments(Rental rental);
  Future<void> saveBluetoothMacAddress(String value);
  Future<String?> getBluetoothMacAddress();
}

class PrinterRemoteDataSrcImpl implements PrinterRemoteDataSource {
  PrinterRemoteDataSrcImpl(this._prefs);

  final SharedPreferences _prefs;

  Future<Uint8List> imagePathToUint8List() async {
    ByteData data = await rootBundle.load('images/logo_print.jpg');
    Uint8List imageBytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return imageBytes;
  }

  @override
  Future<bool> connectToPrinter(String macAddress) async {
    try {
      if (macAddress != '') {
        return await PrintBluetoothThermal.connect(
            macPrinterAddress: macAddress);
      } else {
        return false;
      }
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<BluetoothInfo>> getBondedDevices() async {
    try {
      return await PrintBluetoothThermal.pairedBluetooths;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  void openBluetoothSetting() {
    AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
  }

  @override
  Future<bool> isBluetoothEnabled() async {
    try {
      return await PrintBluetoothThermal.bluetoothEnabled;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<bool> printBill(Rental rental, int? payment, int? change) async {
    try {
      final now = DateTime.now();
      final imageBytes2 = await imagePathToUint8List();
      Image? image = decodeImage(imageBytes2);
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      List<int> bytes = [];

      // Header
      bytes += generator.image(image!);
      bytes += generator.text(
        'IG : @aa__outdoor',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        'Admin : 082131093416',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.emptyLines(1);
      bytes += generator.text(Constants.dateFormatWithHour.format(now));
      bytes += generator.text('Customer: ${rental.name}');
      bytes += generator.hr();

      // Package
      if (rental.listPackage!.isNotEmpty) {
        List<Package>? listPackage = rental.listPackage;

        for (int i = 0; i < listPackage!.length; i++) {
          bytes += generator.text(listPackage[i].name);

          for (int j = 0; j < listPackage[i].listEquipment.length; j++) {
            List<Equipment>? listEquipment = listPackage[i].listEquipment;

            bytes += generator.row([
              PosColumn(width: 1),
              PosColumn(
                  text:
                      '${listEquipment[j].qtyRental} x ${listEquipment[j].name}',
                  width: 11),
            ]);
          }

          bytes += generator.text(
              'Rp ${Constants.formatPrice.format(listPackage[i].totalPrice)}',
              styles: const PosStyles(align: PosAlign.right));
        }
      }

      // Equipment
      if (rental.listEquipment!.isNotEmpty) {
        List<Equipment>? listEquipment = rental.listEquipment;

        for (int i = 0; i < listEquipment!.length; i++) {
          int totalEquipmentPrice =
              listEquipment[i].price * listEquipment[i].qtyRental!;

          bytes += generator.text(listEquipment[i].name);
          bytes += generator.row([
            PosColumn(width: 1),
            PosColumn(
                text:
                    '${listEquipment[i].qtyRental} x ${Constants.formatPrice.format(listEquipment[i].price)}',
                width: 6),
            PosColumn(
                text: 'Rp ${Constants.formatPrice.format(totalEquipmentPrice)}',
                width: 5,
                styles: const PosStyles(align: PosAlign.right)),
          ]);
        }
      }

      // Footer
      bytes += generator.hr();
      bytes += generator.text(
          'Durasi sewa: ${rental.endDate.difference(rental.startDate).inDays} hari',
          styles: const PosStyles(
            align: PosAlign.center,
          ));
      bytes += generator.hr();
      bytes += generator.row([
        PosColumn(
          text: 'Total',
          width: 6,
          styles: const PosStyles(
            bold: true,
          ),
        ),
        PosColumn(
          text: 'Rp ${Constants.formatPrice.format(
            rental.totalPrice,
          )}',
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            bold: true,
          ),
        ),
      ]);

      if (payment != null) {
        bytes += generator.row([
          PosColumn(
            text: rental.paymentType == 'CASH'
                ? 'Tunai'
                : rental.paymentType == 'TRANSFER'
                    ? 'Transfer'
                    : 'QRIS',
            width: 6,
          ),
          PosColumn(
            text: 'Rp ${Constants.formatPrice.format(
              payment,
            )}',
            width: 6,
            styles: const PosStyles(
              align: PosAlign.right,
            ),
          ),
        ]);
        bytes += generator.row([
          PosColumn(
            text: 'Kembalian',
            width: 6,
          ),
          PosColumn(
            text: 'Rp ${Constants.formatPrice.format(
              change,
            )}',
            width: 6,
            styles: const PosStyles(
              align: PosAlign.right,
            ),
          ),
        ]);
      }
      bytes += generator.hr();
      bytes += generator.text(
        'Kembali tanggal',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        Constants.dateFormat.format(rental.endDate),
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.emptyLines(1);
      bytes += generator.text(
        'Terima Kasih',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      );
      bytes += generator.emptyLines(1);
      bytes += generator.text(
        'Harap membawa nota ini saat',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        'mengembalikan peralatan',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.emptyLines(2);

      return await PrintBluetoothThermal.writeBytes(bytes);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<bool> printListEquipments(Rental rental) async {
    try {
      final now = DateTime.now();
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      List<int> bytes = [];

      bytes += generator.emptyLines(1);
      bytes += generator.text(Constants.dateFormatWithHour.format(now));
      bytes += generator.text('Customer: ${rental.name}');
      bytes += generator.hr();

      if (rental.listPackage!.isNotEmpty) {
        for (var i = 0; i < rental.listPackage!.length; i++) {
          for (var j = 0;
              j < rental.listPackage![i].listEquipment.length;
              j++) {
            bytes += generator.text(
                '${rental.listPackage![i].listEquipment[j].name} x ${rental.listPackage![i].listEquipment[j].qtyRental}');
          }
        }
      }

      if (rental.listEquipment!.isNotEmpty) {
        for (var i = 0; i < rental.listEquipment!.length; i++) {
          bytes += generator.text(
              '${rental.listEquipment![i].name} x ${rental.listEquipment![i].qtyRental}');
        }
      }

      bytes += generator.hr();
      bytes += generator.emptyLines(3);

      return await PrintBluetoothThermal.writeBytes(bytes);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<String?> getBluetoothMacAddress() async {
    return _prefs.getString(Constants.keyBtMacAddress);
  }

  @override
  Future<void> saveBluetoothMacAddress(String value) async {
    await _prefs.setString(Constants.keyBtMacAddress, value);
  }
}
