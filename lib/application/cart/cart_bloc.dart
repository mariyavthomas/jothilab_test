import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jothilabproject/infrastructure/hive_operation.dart';
import 'package:jothilabproject/infrastructure/hive_productmode.dart';
import 'cart_event.dart';
import 'cart_state.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_loadCart);
    on<AddToCart>(_addToCart);
    on<RemoveFromCart>(_removeFromCart);
  }

  void _loadCart(LoadCart event, Emitter<CartState> emit) async {
    try {
      List<ProductHiveModel> cartItems = HiveOperations.getDatas();
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError("Failed to load cart"));
    }
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      final product = ProductHiveModel.fromJson(event.product.toJson());
      await HiveOperations.addToCart(product);
      List<ProductHiveModel> updatedCart = HiveOperations.getDatas();
      emit(CartLoaded(updatedCart));
    } catch (e) {
      emit(CartError("Failed to add to cart"));
    }
  }

  void _removeFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      await HiveOperations.removeFromCart(event.productId);
      List<ProductHiveModel> updatedCart = HiveOperations.getDatas();
      emit(CartLoaded(updatedCart));
    } catch (e) {
      emit(CartError("Failed to remove from cart"));
    }
  }
}
