import 'package:equatable/equatable.dart';

import 'category.dart';

class Equipment extends Equatable {
  const Equipment({
    required this.id,
    required this.name,
    required this.price,
    required this.usedQty,
    required this.stockQty,
    required this.active,
    required this.category,
    required this.priceRental,
    required this.qtyRental,
  });

  const Equipment.empty()
      : this(
          id: '',
          name: '',
          price: 0,
          usedQty: 0,
          stockQty: 0,
          active: false,
          category: const Category.empty(),
          priceRental: 0,
          qtyRental: 0,
        );

  final String id;
  final String name;
  final int price;
  final int usedQty;
  final int stockQty;
  final bool active;
  final Category category;
  final int? priceRental;
  final int? qtyRental;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      price,
      usedQty,
      stockQty,
      active,
      category,
      priceRental,
      qtyRental,
    ];
  }
}

class GroupingEquipment extends Equatable {
  const GroupingEquipment({this.listEquipment = const []});
  final List<Equipment> listEquipment;

  Map equipmentQuantity(equipments) {
    var quantity = {};

    equipments.forEach((equipment) {
      if (!quantity.containsKey(equipment)) {
        quantity[equipment] = 1;
      } else {
        quantity[equipment] += 1;
      }
    });

    return quantity;
  }

  int get subtotal =>
      listEquipment.fold(0, (total, current) => total + current.price);

  @override
  List<Object> get props => [listEquipment];
}
