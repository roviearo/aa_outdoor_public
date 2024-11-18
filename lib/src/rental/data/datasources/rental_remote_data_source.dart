import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/utils/constants.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../../../package/domain/entities/package.dart';
import '../models/rental_model.dart';

abstract class RentalRemoteDataSource {
  Future<List<RentalModel>> getListRental();
  Future<List<RentalModel>> getListRentalByStatus(String status);
  Future<RentalModel> getDetailRental(String id);
  Future<void> returnRental(String id);
  Future<void> deleteRental(String id);
  Future<String> addRental(
    String name,
    String address,
    String phoneNumber,
    String nameIdCard,
    String idCardType,
    DateTime startDate,
    DateTime endDate,
    GroupingEquipment groupingEquipment,
    GroupingPackage groupingPackGroupingPackage,
    int paymentNominal,
    String paymentType,
    int returnNominal,
    int totalPrice,
  );
  Future<List<RentalModel>> searchRental(String query);
}

class RentalRemoteDataSrcImpl implements RentalRemoteDataSource {
  RentalRemoteDataSrcImpl(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  @override
  Future<String> addRental(
    String name,
    String address,
    String phoneNumber,
    String nameIdCard,
    String idCardType,
    DateTime startDate,
    DateTime endDate,
    GroupingEquipment groupingEquipment,
    GroupingPackage groupingPackage,
    int paymentNominal,
    String paymentType,
    int returnNominal,
    int totalPrice,
  ) async {
    try {
      var data = {
        'name': name,
        'address': address,
        'phone_number': phoneNumber,
        'name_id_card': nameIdCard,
        'id_card_type': idCardType,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'total_price': totalPrice,
        'payment_type': paymentType,
        'created_at': DateTime.now().toIso8601String(),
      };

      final newRental =
          await _supabaseClient.from('rentals').insert(data).select();

      final rentalId = newRental.first['id'];

      if (groupingPackage.listPackage.isNotEmpty) {
        for (int i = 0;
            i <
                groupingPackage
                    .packageQuantity(groupingPackage.listPackage)
                    .keys
                    .length;
            i++) {
          Package package = groupingPackage
              .packageQuantity(groupingPackage.listPackage)
              .keys
              .elementAt(i);

          await _supabaseClient.from('rental_package').insert({
            'rental_id': rentalId,
            'package_id': package.id,
            'package_qty': groupingPackage
                .packageQuantity(groupingPackage.listPackage)
                .entries
                .elementAt(i)
                .value,
            'price_package': package.totalPrice,
            'created_at': DateTime.now().toIso8601String(),
          });
        }
      }

      if (groupingEquipment.listEquipment.isNotEmpty) {
        for (int i = 0;
            i <
                groupingEquipment
                    .equipmentQuantity(groupingEquipment.listEquipment)
                    .keys
                    .length;
            i++) {
          Equipment equipment = groupingEquipment
              .equipmentQuantity(groupingEquipment.listEquipment)
              .keys
              .elementAt(i);

          await _supabaseClient.from('rental_equipment').insert({
            'rental_id': rentalId,
            'equipment_id': equipment.id,
            'equipment_qty': groupingEquipment
                .equipmentQuantity(groupingEquipment.listEquipment)
                .entries
                .elementAt(i)
                .value,
            'price_rental': equipment.price,
            'created_at': DateTime.now().toIso8601String(),
          });
        }
      }

      return rentalId;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deleteRental(String id) async {
    try {
      await _supabaseClient.from('rentals').delete().match({'id': id});
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<RentalModel> getDetailRental(String id) async {
    try {
      final response = await _supabaseClient
          .from('rentals')
          .select(
              '*, rental_equipment(equipments(*), equipment_qty, price_rental), rental_package(packages(*,package_equipment(equipments(*), equipment_qty)), package_qty, price_package)')
          .eq('id', id)
          .single();

      return RentalModel.fromMap(response);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<RentalModel>> getListRental() async {
    try {
      final response =
          await _supabaseClient.from('rentals').select().order('created_at');

      final data = response.map((data) => RentalModel.fromMap(data)).toList();

      return data;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<RentalModel>> getListRentalByStatus(String status) async {
    try {
      final response = await _supabaseClient
          .from('rentals')
          .select(
              '*, rental_equipment(equipments(*), equipment_qty, price_rental),rental_package(packages(*,package_equipment(equipments(*), equipment_qty)), package_qty, price_package)')
          .filter('status', 'eq', status)
          .order('created_at');

      final data = response.map((data) => RentalModel.fromMap(data)).toList();

      return data;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> returnRental(String id) async {
    try {
      await _supabaseClient
          .from('rentals')
          .update({'status': Constants.rentalDone}).eq('id', id);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<RentalModel>> searchRental(String query) async {
    try {
      final response = await _supabaseClient
          .from('rentals')
          .select(
              '*, rental_equipment(equipments(*), equipment_qty, price_rental),rental_package(packages(*,package_equipment(equipments(*), equipment_qty)), package_qty, price_package)')
          .ilike('name', '%$query%')
          .order('created_at');

      final data = (response).map((data) => RentalModel.fromMap(data)).toList();

      return data;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
