import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/src/equipment/domain/entities.dart';
import '/src/equipment/domain/usecases.dart';

part 'category_bloc.freezed.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required AddCategory addCategory,
    required DeleteCategory deleteCategory,
    required GetListCategory getListCategory,
    required UpdateCategory updateCategory,
  })  : _addCategory = addCategory,
        _deleteCategory = deleteCategory,
        _getListCategory = getListCategory,
        _updateCategory = updateCategory,
        super(const Initial()) {
    on<LoadListCategory>(_onLoadListCategory);
    on<AddCategoryEvent>(_onAddCategoryEvent);
    on<DeleteCategoryEvent>(_onDeleteCategoryEvent);
    on<UpdateCategoryEvent>(_onUpdateCategoryEvent);
  }

  final AddCategory _addCategory;
  final DeleteCategory _deleteCategory;
  final GetListCategory _getListCategory;
  final UpdateCategory _updateCategory;

  _onLoadListCategory(
    LoadListCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    final result = await _getListCategory.call();

    result.fold(
      (failure) => emit(CategoryError(messages: failure.message)),
      (listCategory) => emit(ListCategoryLoaded(listCategory: listCategory)),
    );
  }

  _onAddCategoryEvent(
    AddCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    // emit(const CategoryLoading());

    final result = await _addCategory.call(AddCategoryParams(name: event.name));

    result.fold(
      (failure) => emit(CategoryError(messages: failure.message)),
      (_) => emit(const AddCategorySucceeded()),
    );
  }

  _onDeleteCategoryEvent(
    DeleteCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    final result =
        await _deleteCategory.call(DeleteCategoryParams(id: event.id));

    result.fold(
      (failure) => emit(CategoryError(messages: failure.message)),
      (_) => emit(const DeleteCategorySucceeded()),
    );
  }

  _onUpdateCategoryEvent(
    UpdateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const UpdateCategoryLoading());

    final result = await _updateCategory
        .call(UpdateCategoryParams(id: event.id, name: event.name));

    result.fold(
      (failure) => emit(CategoryError(messages: failure.message)),
      (result) => emit(const UpdateCategorySucceeded()),
    );
  }
}
