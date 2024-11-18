part of 'category_bloc.dart';

@freezed
class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent.loadListCategory() = LoadListCategory;
  const factory CategoryEvent.addCategoryEvent(String name) = AddCategoryEvent;
  const factory CategoryEvent.deleteCategoryEvent(String id) =
      DeleteCategoryEvent;
  const factory CategoryEvent.updateCategoryEvent(String id, String name) =
      UpdateCategoryEvent;
}
