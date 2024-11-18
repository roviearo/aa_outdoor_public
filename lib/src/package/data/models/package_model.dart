import '../../../../core/utils/typedef.dart';
import '../../../equipment/data/models/category_model.dart';
import '../../../equipment/data/models/equipment_model.dart';
import '../../domain/entities/package.dart';

class PackageModel extends Package {
  const PackageModel({
    required super.id,
    required super.name,
    required super.totalPrice,
    required super.active,
    required super.createdAt,
    required super.listEquipment,
    required super.packageQty,
    required super.pricePackage,
  });

  PackageModel.fromMap(DataMap data)
      : this(
          id: data['id'],
          name: data['name'] ?? '',
          totalPrice: data['total_price'],
          active: data['active'],
          createdAt: DateTime.parse(data['created_at']),
          listEquipment: (data['package_equipment'] as List<dynamic>)
              .map((equipment) => EquipmentModel(
                    id: equipment['equipments']['id'],
                    name: equipment['equipments']['name'],
                    price: equipment['equipments']['price'],
                    usedQty: equipment['equipments']['used_qty'],
                    stockQty: equipment['equipments']['stock_qty'],
                    active: equipment['equipments']['active'],
                    category: const CategoryModel(id: '', name: ''),
                    priceRental: equipment['price_rental'],
                    qtyRental: equipment['equipment_qty'],
                  ))
              .toList(),
          packageQty: data['package_qty'],
          pricePackage: data['price_package'],
        );
}
