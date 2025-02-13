// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jothilabproject/application/product/product_bloc.dart';
import 'package:jothilabproject/application/product/product_event.dart';
import 'package:jothilabproject/application/product/product_state.dart';
import 'package:jothilabproject/infrastructure/hive_operation.dart';
import 'package:jothilabproject/infrastructure/hive_productmode.dart';
import 'package:jothilabproject/presention/cart_page/cart_page.dart';
import 'package:jothilabproject/presention/home_page/custom_widgets/grid_list.dart';
import 'package:jothilabproject/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductHiveModel> products = [];

  @override
  void initState() {
    super.initState();
    openBox();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      context.read<ProductBloc>().add(FetchProducts());
    });
  }

  openBox() async {
    await Hive.openBox<ProductHiveModel>("cart").then((_) {
      if (context.mounted) {
        context.read<ProductBloc>().add(FetchProducts());
      }
      products = HiveOperations.getDatas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: CustomColor.greytextColor(),
      appBar: AppBar(
        title: Center(child:  Text("Home",style: TextStyle(color:CustomColor.whiteColor() ),)),
        backgroundColor: CustomColor.greytextColor(),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          final prod = state.products[index];
                          return CustomGridView(
                            prod: prod,
                            callbackDelete: () => context.read<ProductBloc>().add(DeleteFromCart(prod.id!)),
                            callbackAdd: () => context
                                .read<ProductBloc>()
                                .add(AddToCart(prod)), index: index,
                          );
                        },
                        itemCount: state.products.length,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Total Product ${state.products.length}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (state is ProductError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("No Products Available"));
        },
      ),
    );
  }
}
