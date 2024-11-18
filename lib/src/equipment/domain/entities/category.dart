import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({required this.id, required this.name});

  const Category.empty() : this(id: '', name: '');

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
