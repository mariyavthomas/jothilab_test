import 'package:equatable/equatable.dart';
import 'package:jothilabproject/domain/product_model.dart';


abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Products product;
  AddToCart(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final int productId;
  RemoveFromCart(this.productId);

  @override
  List<Object?> get props => [productId];
}
