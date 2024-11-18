import 'package:intl/intl.dart';

class Constants {
  // Format
  static DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
  static DateFormat dateSimpleFormat = DateFormat('dd-MM', 'id_ID');
  static DateFormat dateForParseFormat = DateFormat('yyyy-MM-dd', 'id_ID');
  static DateFormat dateFormatWithHour =
      DateFormat('dd MMMM yyyy HH:mm', 'id_ID');
  static DateFormat dateFormatWithDay =
      DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
  static NumberFormat formatPrice = NumberFormat("#,###", "id_ID");
  static DateFormat hourFormat = DateFormat.Hms();
  static DateFormat monthFormat = DateFormat.MMM('id_ID');

  // String
  static String themeMode = 'themeMode';
  static String equipmentCategory = 'equipmentCategory';
  static String equipmentView = 'equipmentView';
  static String rentalView = 'rentalView';
  static String rentalDone = 'SUDAH DIKEMBALIKAN';
  static String rentalUndone = 'BELUM DIKEMBALIKAN';
  static const String keyBtMacAddress = 'btMacAddress';
}
