import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jothilabproject/application/cart/cart_bloc.dart';
import 'package:jothilabproject/application/cart/cart_event.dart';
import 'package:jothilabproject/application/cart/cart_state.dart';
import 'package:jothilabproject/domain/product_model.dart';
import 'package:jothilabproject/presention/home_page/custom_widgets/grid_list.dart';
import 'package:jothilabproject/utils/colors.dart';
import 'package:jothilabproject/utils/snackbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart()); // Load cart items when screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: CustomColor.greytextColor(),
      appBar: AppBar(
        title:  Text("My Cart", style: TextStyle(fontWeight: FontWeight.bold,color: CustomColor.whiteColor())),
        centerTitle: true,
        backgroundColor:  CustomColor.greytextColor(),
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              snackBarShow(context, "Cart is Open");
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final products = state.products;

            if (products.isNotEmpty) {
              return Stack(
                children: [
                  GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      final prod = products[index];
                      final pro = Products.fromJson(prod.toJson());
                     
                      return CustomGridView(
                        index: index,
                        prod: pro,
                        callbackDelete: () =>
                            context.read<CartBloc>().add(RemoveFromCart(pro.id!)),
                        callbackAdd: () =>
                            context.read<CartBloc>().add(AddToCart(pro)),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        double amt = products.fold(0.0, (sum, item) => sum + item.price!);
                        snackBarShow(context, "Total Amount - $amt");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              );
            } else {
              return const EmptyWidget();
            }
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return const EmptyWidget();
          }
        },
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("There is Nothing Here"));
  }
}
