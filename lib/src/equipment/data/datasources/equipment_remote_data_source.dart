import 'package:supabase_flutter/supabase_flutter.dart';

import '/core/errors/exception.dart';
import '/src/equipment/data/models/category_model.dart';
import '/src/equipment/data/models/equipment_model.dart';
import '/src/equipment/domain/entities.dart';

abstract class EquipmentRemoteDataSource {
  Future<List<Category>> getListCategory();
  Future<void> addCategory(String name);
  Future<void> deleteCategory(String id);
  Future<void> updateCategory(String id, String name);
  Future<List<Equipment>> getListEquipments();
  Future<void> addEquipment(
    String name,
    String price,
    String stockQty,
    String categoryId,
  );
  Future<void> updateEquipment(
    String id,
    String name,
    String price,
    String stockQty,
    String categoryId,
  );
  Future<void> deleteEquipment(String equipmentId);
  Future<List<Equipment>> getListEquipmentsByCategory(String categoryId);
  Future<List<Equipment>> searchEquipment(String query);
}

class EquipmentRemoteDataSrcImpl implements EquipmentRemoteDataSource {
  EquipmentRemoteDataSrcImpl(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Future<void> addCategory(String name) async {
    try {
      await _supabaseClient.from('categories').insert({'name': name});
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await _supabaseClient.from('categories').delete().match({'id': id});
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<Category>> getListCategory() async {
    try {
      final response = await _supabaseClient
          .from('categories')
          .select()
          .order('name', ascending: true);

      final data = response.map((data) => CategoryModel.fromMap(data)).toList();

      return data;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> updateCategory(String id, String name) async {
    try {
      await _supabaseClient
          .from('categories')
          .update({'name': name}).eq('id', id);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> addEquipment(
    String name,
    String price,
    String stockQty,
    String categoryId,
  ) async {
    try {
      var data = {
        'name': name,
        'price': int.parse(price),
        'used_qty': 0,
        'stock_qty': int.parse(stockQty),
        'active': true,
      };

      final insertData =
          await _supabaseClient.from('equipments').insert(data).select();

      final idNewData = insertData.first['id'];

      await _supabaseClient.from('equipment_category').insert({
        'equipment_id': idNewData,
        'category_id': categoryId,
      });
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deleteEquipment(String equipmentId) async {
    try {
      await _supabaseClient
          .from('equipments')
          .update({'active': false}).eq('id', equipmentId);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<Equipment>> getListEquipments() async {
    try {
      final response = await _supabaseClient
          .from('equipments')
          .select('*, categories(*)')
          .eq('active', true)
          .order('name', ascending: true);
      final data =
          (response).map((data) => EquipmentModel.fromMap(data)).toList();

      return data;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<Equipment>> getListEquipmentsByCategory(String categoryId) async {
    try {
      final response = await _supabaseClient
          .from("categories")
          .select(
              'id, equipments(id,name,price,used_qty,stock_qty,active,categories(*))')
          .eq('id', categoryId);
      final data = (response)
          .expand((category) => category['equipments'])
          .map((data) => EquipmentModel.fromMap(data))
          .toList();
      data.removeWhere((equipment) => equipment.active != true);
      data.sort((a, b) => a.name.compareTo(b.name));
      return data;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> updateEquipment(
    String id,
    String name,
    String price,
    String stockQty,
    String categoryId,
  ) async {
    try {
      await _supabaseClient.from('equipments').update({
        'name': name,
        'price': int.parse(price),
        'stock_qty': int.parse(stockQty),
      }).eq('id', id);
      await _supabaseClient.from('equipment_category').update({
        'category_id': categoryId,
      }).eq('equipment_id', id);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<Equipment>> searchEquipment(String query) async {
    try {
      final response = await _supabaseClient
          .from('equipments')
          .select('*, categories(*)')
          .ilike('name', '%$query%')
          .eq('active', true)
          .order('name', ascending: true);
      final data =
          (response).map((data) => EquipmentModel.fromMap(data)).toList();

      return data;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
