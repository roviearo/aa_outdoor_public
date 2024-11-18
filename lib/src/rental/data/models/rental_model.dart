import '../../../../core/utils/typedef.dart';
import '../../../equipment/data/models/category_model.dart';
import '../../../equipment/data/models/equipment_model.dart';
import '../../../package/data/models/package_model.dart';
import '../../domain/entities/rental.dart';

class RentalModel extends Rental {
  const RentalModel({
    required super.id,
    required super.name,
    required super.address,
    required super.phoneNumber,
    required super.nameIdCard,
    required super.idCardType,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.totalPrice,
    required super.createdAt,
    required super.listEquipment,
    required super.listPackage,
    required super.paymentType,
  });

  RentalModel.fromMap(DataMap data)
      : this(
          id: data['id'],
          name: data['name'] ?? '',
          address: data['address'],
          phoneNumber: data['phone_number'],
          nameIdCard: data['name_id_card'] ?? '',
          idCardType: data['id_card_type'],
          startDate: DateTime.parse(data['start_date']),
          endDate: DateTime.parse(data['end_date']),
          status: data['status'],
          totalPrice: data['total_price'],
          createdAt: DateTime.parse(data['created_at']),
          listEquipment: (data['rental_equipment'] as List<dynamic>)
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
          listPackage: (data['rental_package'] as List<dynamic>).map((package) {
            return PackageModel(
                id: package['packages']['id'],
                name: package['packages']['name'],
                totalPrice: package['packages']['total_price'],
                active: package['packages']['active'],
                createdAt: DateTime.parse(package['packages']['created_at']),
                listEquipment:
                    (package['packages']['package_equipment'] as List<dynamic>)
                        .map((equipment) {
                  return EquipmentModel(
                    id: equipment['equipments']['id'],
                    name: equipment['equipments']['name'],
                    price: equipment['equipments']['price'],
                    usedQty: equipment['equipments']['used_qty'],
                    stockQty: equipment['equipments']['stock_qty'],
                    active: equipment['equipments']['active'],
                    category: const CategoryModel(id: '', name: ''),
                    priceRental: equipment['price_rental'],
                    qtyRental: equipment['equipment_qty'],
                  );
                }).toList(),
                packageQty: package['package_qty'],
                pricePackage: package['price_package']);
          }).toList(),
          paymentType: data['payment_type'],
        );
}
