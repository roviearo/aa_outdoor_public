import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';

import '../../../equipment/domain/entities/equipment.dart';
import '../../../package/domain/entities/package.dart';

class Rental extends Equatable {
  const Rental({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.nameIdCard,
    required this.idCardType,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.listEquipment,
    required this.listPackage,
    required this.paymentType,
  });

  const Rental.empty()
      : this(
          id: '',
          name: '',
          address: '',
          phoneNumber: '',
          nameIdCard: '',
          idCardType: '',
          startDate: const ConstDateTime(2022),
          endDate: const ConstDateTime(2022),
          status: '',
          totalPrice: 0,
          createdAt: const ConstDateTime(2022),
          listEquipment: const [],
          listPackage: const [],
          paymentType: '',
        );

  final String id;
  final String name;
  final String? address;
  final String? phoneNumber;
  final String? nameIdCard;
  final String idCardType;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int totalPrice;
  final DateTime createdAt;
  final List<Equipment>? listEquipment;
  final List<Package>? listPackage;
  final String paymentType;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      address,
      phoneNumber,
      nameIdCard,
      idCardType,
      startDate,
      endDate,
      status,
      totalPrice,
      createdAt,
      listEquipment,
      listPackage,
      paymentType,
    ];
  }
}
