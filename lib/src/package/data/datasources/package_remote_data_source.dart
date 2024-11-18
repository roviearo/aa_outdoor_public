import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exception.dart';
import '../../../equipment/domain/entities/equipment.dart';
import '../models/package_model.dart';

abstract class PackageRemoteDataSource {
  Future<List<PackageModel>> getListPackage();
  Future<PackageModel> getDetailPackage(String id);
  Future<void> deletePackage(String id);
  Future<void> addPackage(
    String name,
    int price,
    GroupingEquipment groupingEquipment,
  );
  Future<void> updatePackage(
    String id,
    String name,
    int price,
    GroupingEquipment oldGroupingEquipment,
    GroupingEquipment groupingEquipment,
  );
}

class PackageRemoteDataSrcImpl implements PackageRemoteDataSource {
  PackageRemoteDataSrcImpl(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  @override
  Future<void> addPackage(
    String name,
    int price,
    GroupingEquipment groupingEquipment,
  ) async {
    try {
      var data = {
        'name': name,
        'total_price': price,
        'active': true,
        'created_at': DateTime.now().toIso8601String(),
      };

      final newPackage =
          await _supabaseClient.from('packages').insert(data).select();

      final packageId = newPackage.first['id'];

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

          await _supabaseClient.from('package_equipment').insert({
            'package_id': packageId,
            'equipment_id': equipment.id,
            'equipment_qty': groupingEquipment
                .equipmentQuantity(groupingEquipment.listEquipment)
                .entries
                .elementAt(i)
                .value,
          });
        }
      }
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> updatePackage(
    String id,
    String name,
    int price,
    GroupingEquipment oldGroupingEquipment,
    GroupingEquipment groupingEquipment,
  ) async {
    try {
      await _supabaseClient
          .from('package_equipment')
          .delete()
          .eq('package_id', id);

      await _supabaseClient.from('packages').update({
        'name': name,
        'total_price': price,
      }).eq('id', id);

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

          await _supabaseClient.from('package_equipment').insert({
            'package_id': id,
            'equipment_id': equipment.id,
            'equipment_qty': groupingEquipment
                .equipmentQuantity(groupingEquipment.listEquipment)
                .entries
                .elementAt(i)
                .value,
          });
        }
      }
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deletePackage(String id) async {
    try {
      await _supabaseClient
          .from('packages')
          .update({'active': false}).eq('id', id);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<PackageModel> getDetailPackage(String id) async {
    try {
      final response = await _supabaseClient
          .from('packages')
          .select('*')
          .eq('id', id)
          .single();

      return PackageModel.fromMap(response);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<PackageModel>> getListPackage() async {
    try {
      final response = await _supabaseClient
          .from('packages')
          .select('*, package_equipment(equipments(*), equipment_qty)')
          .filter('active', 'eq', true)
          .order('name', ascending: true);

      final data = response.map((data) => PackageModel.fromMap(data)).toList();

      return data;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
