import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';

import '../../../equipment/domain/entities/equipment.dart';

class Package extends Equatable {
  const Package.empty()
      : this(
          id: '',
          name: '',
          totalPrice: 0,
          active: false,
          createdAt: const ConstDateTime(2022),
          listEquipment: const [],
          packageQty: 0,
          pricePackage: 0,
        );
  const Package({
    required this.id,
    required this.name,
    required this.totalPrice,
    required this.active,
    required this.createdAt,
    required this.listEquipment,
    required this.packageQty,
    required this.pricePackage,
  });

  final String id;
  final String name;
  final int totalPrice;
  final bool active;
  final DateTime createdAt;
  final List<Equipment> listEquipment;
  final int? packageQty;
  final int? pricePackage;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      totalPrice,
      active,
      createdAt,
      listEquipment,
      packageQty,
      pricePackage,
    ];
  }
}

class GroupingPackage extends Equatable {
  const GroupingPackage({this.listPackage = const []});
  final List<Package> listPackage;

  Map packageQuantity(packages) {
    var quantity = {};

    packages.forEach((package) {
      if (!quantity.containsKey(package)) {
        quantity[package] = 1;
      } else {
        quantity[package] += 1;
      }
    });

    return quantity;
  }

  int get subtotal =>
      listPackage.fold(0, (total, current) => total + current.totalPrice);

  @override
  List<Object> get props => [listPackage];
}
