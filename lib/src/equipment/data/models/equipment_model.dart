import '/core/utils/typedef.dart';
import '/src/equipment/data/models/category_model.dart';
import '/src/equipment/domain/entities/equipment.dart';

class EquipmentModel extends Equipment {
  const EquipmentModel({
    required super.id,
    required super.name,
    required super.price,
    required super.usedQty,
    required super.stockQty,
    required super.active,
    required super.category,
    required super.priceRental,
    required super.qtyRental,
  });

  EquipmentModel.fromMap(DataMap data)
      : this(
          id: data['id'],
          name: data['name'],
          price: data['price'],
          usedQty: data['used_qty'],
          stockQty: data['stock_qty'],
          active: data['active'],
          category: CategoryModel.fromMap(data['categories'].first),
          priceRental: data['price_rental'],
          qtyRental: data['equipment_qty'],
        );

  EquipmentModel copyWith({
    String? id,
    String? name,
    int? price,
    int? usedQty,
    int? stockQty,
    bool? active,
    CategoryModel? category,
    int? priceRental,
    int? qtyRental,
  }) {
    return EquipmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      usedQty: usedQty ?? this.usedQty,
      stockQty: stockQty ?? this.stockQty,
      active: active ?? this.active,
      category: category ?? this.category,
      priceRental: priceRental ?? this.priceRental,
      qtyRental: qtyRental ?? this.qtyRental,
    );
  }
}
