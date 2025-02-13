import 'package:equatable/equatable.dart';
import 'package:jothilabproject/domain/product_model.dart';


abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Products> products;
  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartUpdated extends ProductState {}

/// State when the selected page is updated (home/cart)
class PageUpdated extends ProductState {
  final int currentPage;
  PageUpdated(this.currentPage);
}