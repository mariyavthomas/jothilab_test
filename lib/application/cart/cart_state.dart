import 'package:equatable/equatable.dart';
import 'package:jothilabproject/infrastructure/hive_productmode.dart';
abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductHiveModel> products;
  CartLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class CartError extends CartState {
  final String message;
  CartError(this.message);

  @override
  List<Object?> get props => [message];
}
