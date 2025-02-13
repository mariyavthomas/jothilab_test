import 'package:equatable/equatable.dart';
import 'package:jothilabproject/domain/product_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class AddToCart extends ProductEvent {
  final Products product;
  const AddToCart(this.product);
  @override
  List<Object> get props => [product];
}

class DeleteFromCart extends ProductEvent {
  final int id;
  const DeleteFromCart(this.id);
  @override
  List<Object> get props => [id];
}
/// Update the selected page index (for navigation)
class UpdatePage extends ProductEvent {
  final int index;
  UpdatePage(this.index);
}
