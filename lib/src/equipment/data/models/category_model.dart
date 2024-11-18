import '/core/utils/typedef.dart';
import '/src/equipment/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({required super.id, required super.name});

  CategoryModel.fromMap(DataMap data)
      : this(
          id: data['id'],
          name: data['name'],
        );

  CategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
