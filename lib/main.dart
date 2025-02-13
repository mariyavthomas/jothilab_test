import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jothilabproject/application/cart/cart_bloc.dart';
import 'package:jothilabproject/application/login/login_bloc.dart';
import 'package:jothilabproject/application/product/product_bloc.dart';
import 'package:jothilabproject/infrastructure/hive_operation.dart';
import 'package:jothilabproject/infrastructure/hive_productmode.dart';
import 'package:jothilabproject/infrastructure/product_repo.dart';
import 'package:jothilabproject/presention/home_page/home_page.dart';
import 'package:jothilabproject/presention/login_screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  // Ensure all adapters are registered properly
  if (!Hive.isAdapterRegistered(ProductHiveModelAdapter().typeId)) {
    Hive.registerAdapter(ProductHiveModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ReviewsAdapter().typeId)) {
    Hive.registerAdapter(ReviewsAdapter());
  }
  if (!Hive.isAdapterRegistered(MetaAdapter().typeId)) {
    Hive.registerAdapter(MetaAdapter());
  }
  if (!Hive.isAdapterRegistered(DimensionsAdapter().typeId)) {
    Hive.registerAdapter(DimensionsAdapter());
  }
  await Hive.openBox<ProductHiveModel>("cart"); 
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context) => LoginBloc()..add(CheckLoginStatusevent())),
        BlocProvider(create: (context)=>ProductBloc(ProductRepository(), HiveOperations())),
         BlocProvider(create: (context)=>CartBloc())
      ],
     
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? HomePage() : LoginScreen(),
      ),
    );
  }
}
