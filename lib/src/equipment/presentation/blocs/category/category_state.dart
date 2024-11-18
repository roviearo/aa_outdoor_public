part of 'category_bloc.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = Initial;
  const factory CategoryState.loading() = CategoryLoading;
  const factory CategoryState.listCategoryLoaded(
      {required List<Category> listCategory}) = ListCategoryLoaded;
  const factory CategoryState.addCategorySucceeded() = AddCategorySucceeded;
  const factory CategoryState.deleteCategorySucceeded() =
      DeleteCategorySucceeded;
  const factory CategoryState.updateCategoryLoading() = UpdateCategoryLoading;
  const factory CategoryState.updateCategorySucceeded() =
      UpdateCategorySucceeded;
  const factory CategoryState.categoryError({required String messages}) =
      CategoryError;
}
