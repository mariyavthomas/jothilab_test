import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jothilabproject/application/product/product_event.dart';
import 'package:jothilabproject/application/product/product_state.dart';
import 'package:jothilabproject/domain/product_model.dart';
import 'package:jothilabproject/infrastructure/hive_operation.dart';
import 'package:jothilabproject/infrastructure/hive_productmode.dart';
import 'package:jothilabproject/infrastructure/product_repo.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository? repository;
  final HiveOperations? hiveOperations;

  ProductBloc(
    this.repository,
    this.hiveOperations,
  ) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<AddToCart>(_onAddToCart);
    on<DeleteFromCart>(_onDeleteFromCart);
    on<UpdatePage>(_onUpdatePage);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final productsModel = await repository?.getAllProducts();

    if (productsModel != null) {
      emit(ProductLoaded(
          productsModel.products!)); // Extract the list of products
    } else {
      emit(ProductError("Failed to fetch products"));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<ProductState> emit) async {
    final pro = ProductHiveModel.fromJson(event.product.toJson());
    HiveOperations.addToCart(pro);
    emit(CartUpdated());
  }

  void _onDeleteFromCart(
      DeleteFromCart event, Emitter<ProductState> emit) async {
    HiveOperations?.removeFromCart(event.id);
    emit(CartUpdated());
  }

  // Handle Page Updates
  void _onUpdatePage(UpdatePage event, Emitter<ProductState> emit) async {
    int? currentIndex = event.index;
    emit(PageUpdated(currentIndex)); // Emit updated page state
  }
}
